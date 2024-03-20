//
//  AudioPlayerView.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 27.12.2023.
//

import SwiftUI
import ComposableArchitecture

struct AudioPlayerView: View {
    let store: StoreOf<AudioPlayer>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .center, spacing: 18) {
                HStack(spacing: 12) {
                    Text(viewStore.playbackTime.durationString ?? "00:00")
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.secondaryText))
                    SliderView(currentValue: viewStore.binding(
                        get: \.progress,
                        send: { .audioProgressSliderChanged($0)}
                    ))
                    Text(viewStore.duration.durationString ?? "00:00")
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.secondaryText))
                }
                Button(action: {
                    viewStore.send(.playbackSpeedChanged, animation: nil)
                }, label: {
                    Text(viewStore.playbackSpeed.stringValue)
                        .foregroundColor(Color(.primary))
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                        .padding(.init(top: 10, leading: 8, bottom: 10, trailing: 8))
                    
                })
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 6, height: 6))
                        .fill(Color(.secondary))
                )
                playbackControls
            }
        }
        .padding(.vertical)
    }
    
    var playbackControls: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 6) {
                Button(action: {
                    viewStore.send(.previousTapped)
                }) {
                    Image(systemName: "backward.end.fill")
                        .resizable()
                        .frame(
                            width: Constant.PlayerControls.smallButtonSize.width,
                            height: Constant.PlayerControls.smallButtonSize.height
                        )
                        .padding(8)
                }
                .disabled(viewStore.isPreviousAvailable == false)
                .foregroundColor(viewStore.isPreviousAvailable ? Color(.primary) : Color(.secondary))
                
                Button(action: {
                    viewStore.send(.backwardTapped)
                }) {
                    Image(systemName: "gobackward.5")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: Constant.PlayerControls.defaultButtonSize.width,
                            height: Constant.PlayerControls.defaultButtonSize.height
                        )
                }
                .foregroundColor(Color(.primary))
                
                Button(action: {
                    viewStore.send(.playPauseTapped)
                }) {
                    if viewStore.isLoading {
                        ProgressView()
                            .frame(
                                width: Constant.PlayerControls.defaultButtonSize.width,
                                height: Constant.PlayerControls.defaultButtonSize.height
                            )
                            .padding()
                    } else if viewStore.playerState == .playing {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: Constant.PlayerControls.defaultButtonSize.width,
                                height: Constant.PlayerControls.defaultButtonSize.height
                            )
                            .padding()
                    } else {
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: Constant.PlayerControls.defaultButtonSize.width,
                                height: Constant.PlayerControls.defaultButtonSize.height
                            )
                            .padding()
                    }
                }
                .foregroundColor(Color(.primary))
                
                Button(action: {
                    viewStore.send(.forwardTapped)
                }) {
                    Image(systemName: "goforward.10")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: Constant.PlayerControls.defaultButtonSize.width,
                            height: Constant.PlayerControls.defaultButtonSize.height
                        )
                }
                .foregroundColor(Color(.primary))
                
                Button(action: {
                    viewStore.send(.nextTapped)
                }) {
                    Image(systemName: "forward.end.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: Constant.PlayerControls.smallButtonSize.width,
                            height: Constant.PlayerControls.smallButtonSize.height
                        )
                        .padding(8)
                }
                .disabled(viewStore.isNextAvailable == false)
                .foregroundColor(viewStore.isNextAvailable ? Color(.primary) : Color(.secondary))
            }
            .buttonStyle(PlayerButtonStyle())
            .disabled(viewStore.isLoading)
            .padding()
            .alert(store: self.store.scope(state: \.$alert, action: \.alert))
        }
    }
    
    private struct Constant {
        struct PlayerControls {
            static let defaultButtonSize: CGSize = .init(width: 28, height: 28)
            static let smallButtonSize: CGSize = .init(width: 20, height: 20)
        }
    }
}

extension AudioPlayer.PlaybackSpeed {
    
    var stringValue: String {
        switch self {
        case .slow:
            "0.5x speed"
        case .normal:
            "1x speed"
        case .fast1:
            "1.25x speed"
        case .fast2:
            "1.5x speed"
        case .fast3:
            "1.75x speed"
        case .fastest:
            "2x speed"
        }
    }
}
