//
//  LandscapePlayer.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct LandscapePlayer: View {
    
    @Bindable var vm: PlayerViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            VinylDesign(
                size: 60,
                cornerRadius: 8,
                curr: vm.currentTrack,
                font: .title2,
            )
            .padding(.all, 8)
            
            VStack(alignment: .leading, spacing: 2) {
                MarqueeText(
                    text: vm.currentTrack.title,
                    restartToken: vm.currentTrack.id,
                    font: .title2
                )
                .id(vm.currentTrack.id)
                .foregroundStyle(.newPrimary)
                .accessibilityLabel("Song Title")
                .padding(.bottom, 6)
                
                MarqueeText(text: vm.currentArtist,
                            restartToken: vm.currentTrack.id,
                            font: .headline)
                .id(vm.currentTrack.id)
                .foregroundStyle(.secondaryButton)
                .accessibilityLabel("Song Artist")
                
            }
            .frame(alignment: .leading)
            
            HStack(spacing: 2){
                TimeString(text: vm.currentTime, font: .subheadline)
                    .accessibilityLabel("Current Time")
                Text("/")
                    .font(.subheadline)
                    .foregroundStyle(.secondaryButton)
                TimeString(text: vm.currentTrack.duration, font: .subheadline)
                    .accessibilityLabel("Total Duration")
            }
            .monospacedDigit()
            HStack(spacing: 16){
                PreviousButton(vm: vm)
                PlayButton(vm: vm)
                NextButton(vm: vm)
                QueueButton(vm: vm)
                FavoriteButton(vm: vm)
                
            }
            
        }
        
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous).fill(
                .playerBg
            )
        )
        .padding(6)
        
    }
    
    
}
