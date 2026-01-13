//
//  QueueButton.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct QueueButton: View {
    @State var isOpenQueue: Bool = false
    @Bindable var vm: PlayerViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState var focus: Bool
    let font: Font = .title3
    
    
    var body: some View {
        Button {
            isOpenQueue = true
        } label: {
            Image(systemName: "music.note.list")
                .font(font)
                .foregroundStyle(.newPrimary)
                .padding(8)
                .contentShape(Rectangle())
        }
        .accessibilityLabel("Song Queue")
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
        .sheet(isPresented: $isOpenQueue) {
            NavigationStack{
                List(vm.displayQueue) { track in
                    Button(action: {
                        vm.playTrack(track)
                        isOpenQueue = false
                    }){
                        HStack{
                            VinylDesign(
                                size: 40,
                                cornerRadius: 8,
                                curr: track,
                                font: .headline
                            )
                            
                            Text("\(track.title)")
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundStyle(track == vm.currentTrack ? .green : .black)
                        }
                        .hoverEffect(.lift)
                        .focusable()
                    }
                }
                .navigationTitle("Queue")
            }
        }
    }
}
