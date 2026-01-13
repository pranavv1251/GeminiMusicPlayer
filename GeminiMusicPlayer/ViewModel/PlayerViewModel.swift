//
//  PlayerViewModel.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/8/26.
//

import Foundation

enum PlaybackState {
    case playing
    case paused
}

@Observable
@MainActor
final class PlayerViewModel {
    
    private var tracks: [Track]
    var shuffleOn: Bool = false
    var position: Bool = false
    
    private let tickInterval: TimeInterval = 1.0 / 60.0
    
    var isSpinning = false
    var state: PlaybackState = .paused
    
    var currentArtist: String {
        currentTrack.artist.map{
            $0.name
        }
        .joined(separator: ", ")
    }
    
    
    private var currentIndex: Int = 0
    var currentTrack: Track { tracks[currentIndex] }
    
    var currentTime: Double = 0
    
    
    private var favorites: Set<UUID> = []
    var isFavorite: Bool { favorites.contains(currentTrack.id) }
    
    
    var timer: Timer?
    
    init(tracks: [Track]) {
        self.tracks = tracks
    }
    
    @MainActor deinit {
        stopTimer()
    }
    
    func play() {
        guard state != .playing else { return }
        state = .playing
        startTimer()
    }
    
    func pause() {
        guard state == .playing else { return }
        state = .paused
        stopTimer()
    }

    func togglePlayPause() {
        switch state {
        case .playing:
            pause()
        case .paused:
            play()
        }
    }
    
    func playTrack(_ track: Track){
        guard let idx = tracks.firstIndex(where: { $0.id == track.id }) else { return }
        
        currentIndex = idx
        currentTime = 0
        
        state = .playing
        startTimer()
    }
    
    func next() {
        stopTimer()
        currentIndex = (currentIndex + 1) % tracks.count
        currentTime = 0
        if state == .playing { startTimer() }
    }
    
    func previous() {
        stopTimer()
        currentIndex = (currentIndex - 1 + tracks.count) % tracks.count
        currentTime = 0
        if state == .playing { startTimer() }
    }
    
    func toggleFavorite() {
        let id = currentTrack.id
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }
    
    func seek(to newTime: Double) {
        currentTime = min(max(0, newTime), currentTrack.duration)
    }
    
    private func tick() {
        guard state == .playing else { return }
        
        let next = currentTime + tickInterval
        
        if next >= currentTrack.duration {
            currentTime = currentTrack.duration
            stopTimer()
            state = .paused
        } else {
            currentTime = next
        }
    }

    
    func toggleShuffle(){
        shuffleOn.toggle()
    }

    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in
                self.tick()
            }
        }
    
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension PlayerViewModel {
    var displayQueue: [Track] {
        guard !tracks.isEmpty else { return [] }
        let start = max(0, min(currentIndex, tracks.count - 1))
        return Array(tracks[start...]) + Array(tracks[..<start])
    }
}
//
//timer = Timer(timeInterval: tickInterval, repeats: true) { [weak self] _ in
//    guard let self else { return }
//    
//    MainActor.assumeIsolated {
//        self.tick()
//    }
//}
//
//RunLoop.main.add(timer!, forMode: .common)

