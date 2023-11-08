//
//  VideoView.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 07/11/23.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @State var name: String
    @State var avPlayer = AVPlayer()
    @State var isPaused = false
    
    var body: some View {
        VStack {
            AVPlayerController(player: avPlayer)
                .frame(width: 358, height: 300)
                .cornerRadius(12)
                .onAppear {
                    avPlayer.play()
                }
            Button("Play/Pause") {
                if isPaused{
                    avPlayer.play()
                    isPaused = false
                }else{
                    avPlayer.pause()
                    isPaused = true
                }
            }
            
        }
        .onAppear {
            self.avPlayer = AVPlayer(url: Bundle.main.url(forResource: name, withExtension: "MOV")!)
        }
    }
}

#Preview {
    VideoView(name: "video")
}
