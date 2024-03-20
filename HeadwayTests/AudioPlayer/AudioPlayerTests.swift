//
//  HeadwayTests.swift
//  HeadwayTests
//
//  Created by Pavlo Tanaiev on 12.12.2023.
//

import XCTest
import ComposableArchitecture
@testable import Headway

final class AudioPlayerTests: XCTestCase {
    
    
    enum TestError: Error {
        case testError
    }
    
    @MainActor
    func testPlayAudio() async {
        enum TestError: Error {
            case testError
        }
        
        let audioPlayerMock = AudioPlayerClientMock()
        let store = TestStore(initialState: AudioPlayer.State(duration: 100, playbackTime: 1, progress: 0.5)) {
            AudioPlayer()
        } withDependencies: {
            $0.audioPlayer = audioPlayerMock
            $0.continuousClock = TestClock()
        }
        
        await store.send(.playAudio(URL(string: "url")!)) {
            $0.playerState = .playing
        }
        audioPlayerMock.error = TestError.testError
        await store.receive(\.playbackStarted)
        
        await store.send(.onPlayerError(TestError.testError)) {
            $0.alert = AlertState {
                TextState("Audio error")
            } message: {
                TextState(TestError.testError.localizedDescription)
            }
        }
    }
    
    @MainActor
    func testPlayerControls() async {
        
        let audioPlayerMock = AudioPlayerClientMock()
        let store = TestStore(initialState: AudioPlayer.State(duration: 100, playbackTime: 1, progress: 0.5)) {
            AudioPlayer()
        } withDependencies: {
            $0.audioPlayer = audioPlayerMock
            $0.continuousClock = TestClock()
        }
        
        await store.send(.seekTo(50.0)) {
            $0.playbackTime = 50.0
            $0.progress = 50.0 / $0.duration
        }
        
        await store.send(.audioProgressSliderChanged(0.2))
        await store.receive(\.playbackTimeChanged) {
            let newPlaybackTime = $0.duration * 0.2
            $0.playbackTime = newPlaybackTime
            $0.progress = newPlaybackTime / $0.duration
        }
        
        await store.send(.playPauseTapped) {
            $0.playerState = .playing
        }
        await store.receive(\.playbackStarted)
        await store.send(.playPauseTapped) {
            $0.playerState = .paused
        }
        
        await store.send(.forwardTapped)
        await store.receive(\.seekTo) {
            let time = $0.playbackTime + 10.0
            $0.playbackTime = time
            $0.progress = time / $0.duration
        }
        
        await store.send(.backwardTapped)
        await store.receive(\.seekTo) {
            let time = $0.playbackTime - 5.0
            $0.playbackTime = time
            $0.progress = time / $0.duration
        }
        
        await store.send(.playbackSpeedChanged) {
            $0.playbackSpeed = .fast1
            $0.playerState = .playing
        }
        audioPlayerMock.error = TestError.testError
        await store.receive(\.playbackStarted)
        await store.send(.onPlayerError(TestError.testError)) {
            $0.alert = AlertState {
                TextState("Audio error")
            } message: {
                TextState(TestError.testError.localizedDescription)
            }
        }
    }
}
