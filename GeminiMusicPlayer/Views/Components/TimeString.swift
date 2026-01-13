//
//  TimeString.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct TimeString: View {
    var text: Double
    var font: Font = .caption
    
    var body: some View {
        Text(timeToString(text))
            .font(font)
            .foregroundColor(.secondaryButton)
    }
    
    private func timeToString(_ seconds: Double) -> String {
        guard seconds.isFinite else { return "--:--" }
        let s = max(0, Int(seconds.rounded()))
        return String(format: "%d:%02d", s / 60, s % 60)
    }
    
}
