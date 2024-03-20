//
//  AudioPlayerCore.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 19.12.2023.
//

import ComposableArchitecture
import AVFoundation
import Combine

@Reducer
struct AudioPlayer {
    
    enum PlayerMode {
        case playing
        case paused
    }
    
    enum PlaybackSpeed: Float, CaseIterable {
        case slow = 0.5
        case normal = 1.0
        case fast1 = 1.25
        case fast2 = 1.5
        case fast3 = 1.75
        case fastest = 2.0
    }
    
    struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
        var playerState: PlayerMode = .paused
        var playbackSpeed: PlaybackSpeed = .normal
        var duration: Double = 0.0
        var playbackTime: Double = 0
        var progress: Double = 0
        var isLoading: Bool = false
        var isNextAvailable: Bool = true
        var isPreviousAvailable: Bool = true
    }
    
    enum Action {
        case playPauseTapped
        case playAudio(URL)
        case previousTapped
        case nextTapped
        case backwardTapped
        case forwardTapped
        case audioProgressSliderChanged(Double)
        case seekTo(Double)
        case playbackTimeChanged(Double)
        case durationUpdated(Double)
        case playbackStarted
        case playbackSpeedChanged
        case alert(PresentationAction<Alert>)
        case onPlayerError(Error?)
        case stop
        enum Alert: Equatable {}
    }
    
    @Dependency(\.audioPlayer) var audioPlayer
    @Dependency(\.continuousClock) var clock
    private enum CancellableIdentified { case play }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .playPauseTapped:
                if state.playerState == .playing {
                    state.playerState = .paused
                    audioPlayer.pause()
                    return .cancel(id: CancellableIdentified.play)
                } else {
                    state.playerState = .playing
                    audioPlayer.play()
                    return .send(.playbackStarted)
                }
            case let .playAudio(url):
                state.playerState = .playing
                audioPlayer.playAudio(with: url)
                return .send(.playbackStarted)
            case .previousTapped:
                audioPlayer.pause()
                return .none
            case .nextTapped:
                audioPlayer.pause()
                return .none
            case .backwardTapped:
                let newTime = state.playbackTime - 5
                return .send(.seekTo(max(newTime, 0)))
            case .forwardTapped:
                let newTime = state.playbackTime + 10
                return .send(.seekTo(min(newTime, state.duration)))
            case let .audioProgressSliderChanged(newProgress):
                let newPlaybackTime = state.duration * newProgress
                audioPlayer.seek(to: newPlaybackTime)
                return .send(.playbackTimeChanged(newPlaybackTime))
            case let .seekTo(newPlaybackTime):
                state.playbackTime = newPlaybackTime
                state.progress = newPlaybackTime / state.duration
                audioPlayer.seek(to: newPlaybackTime)
                return .none
            case let .playbackTimeChanged(newPlaybackTime):
                state.playbackTime = newPlaybackTime
                state.progress = newPlaybackTime / state.duration
                return .none
            case let .durationUpdated(duration):
                if state.duration != duration, duration > 0 {
                    state.duration = duration
                }
                return .none
            case .playbackStarted:
                return .run { send in
                    var start: TimeInterval = 0
                    
                    // This is mostly like wrapped observers to get values from AVPlayer,
                    // Will be better to create separate composable implementation for AVPlayer itself
                    // but might take a lot of time
                    
                    for await _ in self.clock.timer(interval: .milliseconds(500)) {
                        start += 0.5
                        await send(.durationUpdated(self.audioPlayer.duration))
                        await send(.playbackTimeChanged(self.audioPlayer.currentTime))
                        await send(.onPlayerError(self.audioPlayer.error))
                    }
                }.cancellable(id: CancellableIdentified.play)
            case .playbackSpeedChanged:
                let nextSpeed: PlaybackSpeed = .allCases.nextItem(after: state.playbackSpeed) ?? .normal
                state.playbackSpeed = nextSpeed
                audioPlayer.setRate(nextSpeed.rawValue)
                state.playerState = .playing
                return .send(.playbackStarted)
            case .alert(.dismiss):
                return .send(.nextTapped)
            case .alert(.presented(_)):
                return .none
            case let .onPlayerError(error):
                guard let error else { return .none }
                state.alert = AlertState {
                    TextState("Audio error")
                } message: {
                    TextState(error.localizedDescription)
                }
                return .cancel(id: CancellableIdentified.play)
            case .stop:
                return .cancel(id: CancellableIdentified.play)
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
