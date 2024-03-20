//
//  AudioPlayerClient.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 26.12.2023.
//

import Foundation
import AVFoundation

protocol AudioPlayerClientProtocol: NSObjectProtocol {
    var duration: TimeInterval { get }
    var currentTime: TimeInterval { get }
    var error: Error? { get }

    func playAudio(with url: URL)
    func play()
    func pause()
    func setRate(_ rate: Float)
    func seek(to time: TimeInterval)
}

final class AudioPlayerClient: NSObject, AudioPlayerClientProtocol {
    
    private(set) var duration: TimeInterval = 0.0
    private(set) var currentTime: TimeInterval = 0.0
    private(set) var error: Error?
    
    private let errorKeyPath = "error"
    private let player = AVPlayer()
    private var timeObserver: Any?
    
    
    func playAudio(with url: URL) {
        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
        player.play()
        item.addObserver(self, forKeyPath: errorKeyPath, options: [.new, .old], context: nil)
        addPeriodicTimeObserver()
        error = nil
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func setRate(_ rate: Float) {
        player.rate = rate
    }
    
    func seek(to time: TimeInterval) {
        let cmTime = CMTime(seconds: time, preferredTimescale: 1)
        player.seek(to: cmTime)
    }
    
    deinit {
        removePeriodicTimeObserver()
        player.removeObserver(self, forKeyPath: errorKeyPath)
    }
}

// MARK: - Private methods

extension AudioPlayerClient {
    private func addPeriodicTimeObserver() {
        let interval = CMTime(value: 1, timescale: 2)
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval,
                                                      queue: .main) { [weak self] time in
            guard let self else { return }
            currentTime = time.seconds
            duration = player.currentItem?.duration.seconds ?? 0.0
        }
    }

    private func removePeriodicTimeObserver() {
        guard let timeObserver else { return }
        player.removeTimeObserver(timeObserver)
        self.timeObserver = nil
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "error", let item = object as? AVPlayerItem, let error = item.error {
            self.error = error
        }
    }
}
