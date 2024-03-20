//
//  HeadwayApp.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 12.12.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct HeadwayApp: App {
    var body: some Scene {
        WindowGroup {
            BookKeypointsView.init(store: .init(initialState: .init(playerState: .init()), reducer: {
                BookKeypoints()
            }))
        }
    }
}
