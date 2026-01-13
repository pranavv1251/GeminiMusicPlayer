//
//  FavoriteButton.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct FavoriteButton: View {
    @Bindable var vm: PlayerViewModel
    @FocusState var focus: Bool
    let font: Font = .title3
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                vm.toggleFavorite()
            }
        } label: {
            Image(systemName: vm.isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(vm.isFavorite ? .red : .newPrimary)
                .font(font)
                .symbolEffectsRemoved(!vm.isFavorite)
                .symbolEffect(.bounce)
        }
        .accessibilityLabel(vm.isFavorite ? "Unfavorite" : "Favorite")
        
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
