//
//  AudioPlayerClientMock.swift
//  HeadwayTests
//
//  Created by Pavlo Tanaiev on 28.12.2023.
//

import Foundation
@testable import Headway

final class AudioPlayerClientMock: NSObject, AudioPlayerClientProtocol {
    
    var duration: TimeInterval = 2
    
    var currentTime: TimeInterval = 1
    
    var error: Error?
    
    func playAudio(with url: URL) { }
    
    func play() { }
    
    func pause() { }
    
    func setRate(_ rate: Float) { }
    
    func seek(to time: TimeInterval) {
        currentTime = time
    }
}
