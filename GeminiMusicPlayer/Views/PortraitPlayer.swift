//
//  PlayerView.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/8/26.
//

import SwiftUI

struct PortraitPlayer: View {
    
    @Bindable var vm: PlayerViewModel
    @State private var isScrubbing = false
    @State private var scrubValue: Double = 0
    
    
    var body: some View {
        VStack(spacing: 10) {
            
            // Vinyl + Title + Artist + Queue
            HStack(spacing: 12) {
                VinylDesign(
                    curr: vm.currentTrack,
                    font: .largeTitle,
                )
                .padding(.all, 6)
                
                VStack(alignment: .leading, spacing: 2) {
                    MarqueeText(
                        text: vm.currentTrack.title,
                        restartToken: vm.currentTrack.id,
                        font: .title2
                    )
                    .id(vm.currentTrack.id)
                    .foregroundStyle(.newPrimary)
                    .padding(.vertical, 6)
                    .bold()
                    
                    MarqueeText(text: vm.currentArtist,
                                restartToken: vm.currentTrack.id,
                                font: .headline)
                    .id(vm.currentTrack.id)
                    .foregroundStyle(.secondaryButton)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                QueueButton(vm: vm)
                

            }
            
            // Slider + Time labels
            VStack(spacing: 6) {
                SeekSlider(
                    vm: vm,
                    isScrubbing: $isScrubbing,
                    scrubValue: $scrubValue
                )
            
                HStack {
                    TimeString(text: isScrubbing ? scrubValue : vm.currentTime)
                        .accessibilityLabel("Time Elapsed")
                    Spacer()
                    TimeString(text: vm.currentTrack.duration)
                        .accessibilityLabel("Time Remaining")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .monospacedDigit()
            }
            
            // Controls
            HStack(alignment: .center, spacing: 40) {
                
                ShuffleButton(vm: vm)
                
                PreviousButton(vm: vm)
                
                PlayButton(vm: vm)
                
                NextButton(vm: vm)
                
                FavoriteButton(vm: vm)
            }
            
        }
        
        .padding(20)
        .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous).fill(
                    .playerBg
            
            )
        )
        .padding(6)
        
    }
    
    
}
