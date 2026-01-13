//
//  SeekSlider.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct SeekSlider: View {
    @Bindable var vm: PlayerViewModel
    @Binding var isScrubbing: Bool
    @Binding var scrubValue: Double
    
    var body: some View{
        Slider(
            value: Binding(
                get: { isScrubbing ? scrubValue : vm.currentTime },
                set: { newVal in
                    isScrubbing = true
                    scrubValue = newVal
                }
            ),
            in: 0...max(vm.currentTrack.duration, 0.01),
            onEditingChanged: { editing in
                if !editing {
                    vm.seek(to: scrubValue)
                    isScrubbing = false
                }
            }
        )
        .accessibilityLabel("Seek Slider")
        .accessibilityValue("\(Int(scrubValue)) seconds")
        .tint(.newPrimary)
        .onAppear(){
            let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold)
            let circleImage = UIImage(
                systemName: "circle.fill",
                withConfiguration: config
            )
            UISlider.appearance().setThumbImage(circleImage, for: .normal)
        }
    }
}
