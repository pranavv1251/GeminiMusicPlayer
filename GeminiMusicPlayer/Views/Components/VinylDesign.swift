//
//  VinylDesign.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct VinylDesign: View {
    var size: CGFloat = 80
    var cornerRadius: CGFloat = 12
    var curr: Track
    var font: Font
    
    var body: some View {
        Group {
            if let name = curr.imageAsset {
                Image(name).resizable()
            } else {
                Image(systemName: "music.note")
                    .font(font)
                    .foregroundColor(.secondaryButton)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.newPrimary)
            }
        }
        .scaledToFill()
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
}
