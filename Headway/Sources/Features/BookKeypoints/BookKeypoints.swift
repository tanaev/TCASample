//
//  AudiobookPlayerCore.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 19.12.2023.
//

import Foundation
import ComposableArchitecture

@Reducer
struct BookKeypoints {
    
    struct State: Equatable {
        @PresentationState var playerState: AudioPlayer.State?
        @PresentationState var alert: AlertState<Action.Alert>?
        var keyPoints: [BookKeyPoint] = []
        var currentKeypoint: BookKeyPoint?
        var coverImageUrl: URL?
        var currentKeypointIndex = 0
    }
    
    enum Action {
        case onAppear
        case bookResponse(Result<Book, Error>)
        case audioPlayer(PresentationAction<AudioPlayer.Action>)
        case beginCurrentKeyPoint
        case alert(PresentationAction<Alert>)
        
        enum Alert: Equatable {}
    }
    
    @Dependency(\.apiClient) var apiClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.playerState?.isLoading = true
                return .run { send in
                    await send(.bookResponse(Result { try await self.apiClient.book() }))
                }
            case let .audioPlayer(player):
                guard case let .presented(playerAction) = player else { return .none }
                
                switch playerAction {
                case .nextTapped:
                    if state.currentKeypointIndex < state.keyPoints.count - 1 {
                        state.currentKeypointIndex += 1
                    }
                    return .send(.beginCurrentKeyPoint)
                case .previousTapped:
                    if state.currentKeypointIndex > 0 {
                        state.currentKeypointIndex -= 1
                    }
                    return .send(.beginCurrentKeyPoint)
                default:
                    return .none
                }
            case let .bookResponse(.success(response)):
                state.playerState?.isLoading = false
                state.keyPoints = response.keyPoints
                state.coverImageUrl = response.coverImageUrl
                return .send(.beginCurrentKeyPoint)
            case let .bookResponse(.failure(error)):
                state.keyPoints = []
                state.currentKeypointIndex = 0
                state.playerState?.isLoading = false
                state.alert = AlertState {
                    TextState(error.localizedDescription)
                }
                return .none
            case .beginCurrentKeyPoint:
                let currentKeypoint = state.keyPoints[state.currentKeypointIndex]
                state.currentKeypoint = currentKeypoint
                
                let isPreviousAvailable = state.currentKeypointIndex > 0
                state.playerState?.isPreviousAvailable = isPreviousAvailable
                
                let isNextAvailable = state.currentKeypointIndex < state.keyPoints.count - 1
                state.playerState?.isNextAvailable = isNextAvailable
                return .send(.audioPlayer(.presented(.playAudio(currentKeypoint.audioUrl))))
            case .alert(.dismiss):
                return .send(.onAppear)
            case .alert(.presented(_)):
                return .none
            }
        }
        .ifLet(\.$playerState, action: \.audioPlayer) {
            AudioPlayer()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
