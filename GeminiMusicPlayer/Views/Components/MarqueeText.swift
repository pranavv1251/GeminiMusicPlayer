//
//  MarqueeText.swift
//  GeminiMusic
//
//  Created by Pranav Gangurde on 1/11/26.
//

import SwiftUI

struct MarqueeText: View {
    let text: String
    let restartToken: UUID
    
    var font: Font = .headline
    var speed: CGFloat = 30
    var pause: Double = 0.8
    
    @State private var textWidth: CGFloat = 0
    @State private var containerWidth: CGFloat = 0
    @State private var offset: CGFloat = 0
    @State private var loopTask: Task<Void, Never>?
    
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            
            ZStack(alignment: .leading) {
                Text(text)
                    .font(font)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .offset(x: offset)
                    .background(
                        GeometryReader { tgeo in
                            Color.clear
                                .onAppear { updateTextWidth(tgeo.size.width) }
                                .onChange(of: tgeo.size.width) { _, new in
                                    updateTextWidth(new)
                                }
                        }
                    )
            }
            .frame(width: w, alignment: .leading)
            .clipped()
            .onAppear { updateContainerWidth(w) }
            .onChange(of: w) { _, new in updateContainerWidth(new) }
            .onChange(of: restartToken) { _, _ in restart() }
            .onChange(of: text) { _, _ in restart() }
        }
        .frame(height: 22)
        .onDisappear { stop() }
    }
    
    private func updateTextWidth(_ w: CGFloat) {
        if abs(textWidth - w) > 0.5 {
            textWidth = w
            restart()
        }
    }
    
    private func updateContainerWidth(_ w: CGFloat) {
        if abs(containerWidth - w) > 0.5 {
            containerWidth = w
            restart()
        }
    }
    
    private func restart() {
        stop()
        offset = 0
        startIfNeeded()
    }
    
    private func stop() {
        loopTask?.cancel()
        loopTask = nil
    }
    
    private func startIfNeeded() {
        let travel = max(0, textWidth - containerWidth)
        guard travel > 1 else { return }
        
        let duration = Double(travel / speed)
        
        loopTask = Task {
            while !Task.isCancelled {
                await MainActor.run {
                    withAnimation(.linear(duration: duration)) { offset = -travel }
                }
                try? await Task.sleep(nanoseconds: UInt64((duration + pause) * 1_000_000_000))
                
                await MainActor.run {
                    withAnimation(.linear(duration: duration)) { offset = 0 }
                }
                try? await Task.sleep(nanoseconds: UInt64((duration + pause) * 1_000_000_000))
            }
        }
    }
}



