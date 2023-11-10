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
            VideoPlayer(player: avPlayer)
                .scaleEffect(1.57)
                .frame(width: 358, height: 316)
                .cornerRadius(12)
                .onAppear {
                    avPlayer.play()
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { _ in
                            avPlayer.seek(to: .zero)
                            avPlayer.play()
                                       }
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
            self.avPlayer = AVPlayer(url: URL(string: name)!)
        }
    }
}

#Preview {
    VideoView(name: "https://cdn.flowplayer.com/a30bd6bc-f98b-47bc-abf5-97633d4faea0/hls/de3f6ca7-2db3-4689-8160-0f574a5996ad/playlist.m3u8")
}
