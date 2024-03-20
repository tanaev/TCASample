//
//  AudioPlayerClientDependencies.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 26.12.2023.
//

import Foundation
import Dependencies

private enum AudioPlayerClientKey: DependencyKey {
    static let liveValue: AudioPlayerClientProtocol = AudioPlayerClient()
}


extension DependencyValues {
    var audioPlayer: AudioPlayerClientProtocol {
        get { self[AudioPlayerClientKey.self] }
        set { self[AudioPlayerClientKey.self] = newValue }
    }
}
