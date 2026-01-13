//
//  Library.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/8/26.
//
import Foundation

struct Artists{
    let artists: [Artist] = [
        Artist(
            id: UUID(),
            name: "Pranav Gangurde"
        ),
        Artist(
            id: UUID(),
            name: "The Band"
        ),
        Artist(
            id: UUID(),
            name: "Linkin Park"
        ),
        Artist(
            id: UUID(),
            name: "Taylor Swift"
        )
    ]
}

struct Library{
    static let artist = Artists().artists
    static let tracks: [Track] = [
        Track(
            id: UUID(),
            title: "Short Song Title",
            artist: [artist[0]],
            imageAsset: "image1",
            duration: 10,
            album: "Demo Album"
        ),
        Track(
            id: UUID(),
            title: "Long Song Title for sample track (For Long Scroll Purposes) and also bigger",
            artist: [artist[0], artist[1], artist[2]],
            imageAsset: "image3",
            duration: 25,
            album: nil
        ),
        Track(
            id: UUID(),
            title: "Different Long Song Title with no Image (But still a pretty big one)",
            artist: [artist[2], artist[3], artist[0], artist[1]],
            imageAsset: nil,
            duration: 15,
            album: nil
        )
    ]

    
}

