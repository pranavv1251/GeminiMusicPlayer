//
//  PreviousButton.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct PreviousButton: View {
    @Bindable var vm: PlayerViewModel
    @FocusState var focus: Bool
    let font: Font = .title3
    
    var body: some View {
        Button { vm.previous() } label: {
            Image(systemName: "backward.end.fill")
                .foregroundStyle(.newPrimary)
                .font(font)
        }
        .accessibilityLabel("Previous")
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
