//
//  GeminiMusicPlayerApp.swift
//  GeminiMusicPlayer
//
//  Created by Pranav Gangurde on 1/12/26.
//

import SwiftUI

@main
struct GeminiMusicPlayerApp: App {
    
    init() {
        let slider = UISlider.appearance()
        slider.minimumTrackTintColor = UIColor(.newPrimary)
        slider.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.25)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
