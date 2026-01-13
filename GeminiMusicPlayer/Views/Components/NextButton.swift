//
//  NextButton.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct NextButton: View {
    
    @Bindable var vm: PlayerViewModel
    @FocusState private var focus: Bool
    let font: Font = .title3
    
    var body: some View {
        Button { vm.next() } label: {
            Image(systemName: "forward.end.fill")
                .foregroundStyle(.newPrimary)
                .font(font)
        }
        .accessibilityLabel("Next")
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
