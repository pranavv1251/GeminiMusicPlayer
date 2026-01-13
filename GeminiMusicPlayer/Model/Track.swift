//
//  Track.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/8/26.
//

import Foundation

struct Track: Identifiable, Equatable{
    
    let id: UUID
    let title: String
    let artist: [Artist]
    let imageAsset: String?
    let duration: Double
    
    let album: String?
}
