//
//  ContentView.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 12.12.2023.
//

import SwiftUI
import ComposableArchitecture

struct BookKeypointsView: View {
    let store: StoreOf<BookKeypoints>
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea(edges: .all)
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                GeometryReader { reader in
                    VStack(alignment: .center, spacing: 16) {
                        AsyncImage(
                            url: viewStore.coverImageUrl,
                            content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            },
                            placeholder: {
                                Spacer()
                            }
                        )
                        .frame(width: reader.size.width - Constant.imageHorizontalMargin * 2,
                               height: (reader.size.width - Constant.imageHorizontalMargin * 2) * 1.5)
                        VStack(spacing: 16){
                            Text("KEY POINT \(viewStore.currentKeypointIndex + 1) OF \(viewStore.keyPoints.count)")
                                .fontWeight(.semibold)
                                .font(.system(size: 12))
                                .foregroundStyle(Color(.secondaryText))
                                .padding(.init(top: 24, leading: 0, bottom: 0, trailing: 0))
                            VStack {
                                Text(viewStore.currentKeypoint?.description ?? "")
                                    .fontWeight(.regular)
                                    .font(.system(size: 14))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            .frame(height: 42)
                        }
                        IfLetStore(
                            self.store.scope(state: \.$playerState, action: \.audioPlayer)
                        ) { store in
                            AudioPlayerView(store: store)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                }.onAppear(perform: {
                    store.send(.onAppear)
                })
                .padding()
                .alert(store: self.store.scope(state: \.$alert, action: \.alert))
            }
            
        }
        .padding(0)
    }
    
    private struct Constant {
        static let imageHorizontalMargin: CGFloat = 75
    }
}
