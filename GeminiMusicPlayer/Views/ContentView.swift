import SwiftUI



struct ContentView: View {
    
    @State private var vm = PlayerViewModel(tracks: Library.tracks)
    @State private var offset = CGFloat.zero
    
    var body: some View {
        GeometryReader{ reader in
            let isLandscape = reader.size.width > reader.size.height
            
            NavigationStack{
                List(1..<21, id: \.self) { i in
                    NavigationLink {
                        Text("Page \(i)")
                    } label: {
                        Text("Page \(i)")
                    }
                }
                .navigationTitle("Sample Pages")
                .scrollContentBackground(.hidden)
                
            }
            .safeAreaInset(edge: vm.position ? .top : .bottom) {
                Group {
                    if isLandscape {
                        LandscapePlayer(vm: vm)
                    } else {
                        PortraitPlayer(vm: vm)
                    }
                }
                    .padding(.bottom, 8)
                    .offset(y: offset)
//
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}



//.gesture(
    //                        DragGesture()
    //                            .onChanged { value in
    //                                offset = value.translation.height
    //                            }
    //                            .onEnded { value in
    //                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
    //                                    let threshold: CGFloat = 150
    //                                    let dy = value.translation.height
    //                                    if !vm.position && dy < -threshold {
    //                                        vm.position = true
    //                                    } else if vm.position && dy > threshold {
    //                                        vm.position = false
    //                                    }
    //                                    offset = .zero
    //                                }
    //                            }
    //                    )
