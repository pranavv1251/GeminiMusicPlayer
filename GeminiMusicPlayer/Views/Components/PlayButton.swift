//
//  PlayButton.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct PlayButton: View {
    
    @Bindable var vm: PlayerViewModel
    @FocusState private var focus: Bool
    let size: Int = 58
    
    var body: some View {
        Button { vm.togglePlayPause() } label: {
            Image(
                systemName: vm.state == .playing ? "pause.circle.fill" : "play.circle.fill"
            )
            .font(.system(size: 58))
            .symbolRenderingMode(.palette)
            .foregroundStyle(.newPrimary, .button)
            .contentTransition(.symbolEffect(.replace))
        }
        .accessibilityLabel(vm.state == .playing ? "Pause" : "Play")
        .hoverEffect(.lift)
        .focusable()
        .focused($focus)
        .focusEffectDisabled()
        .overlay(
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .stroke(focus ? .secondaryButton : .clear, lineWidth: 2)
                .padding(-4)
            
        )
        .animation(.easeOut(duration: 0.15), value: focus)
    }
}
