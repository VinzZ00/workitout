//
//  VideoPlayerView.swift
//  Mamaste
//
//  Created by Kevin Dallian on 19/11/23.
//

import SwiftUI

struct VideoPlayerView: View {
    var videoURLManager = VideoURLManager()
    var body: some View {
        WebView(url: videoURLManager.generateURL(videoID: "snYu2JUqSWs"))
            .frame(width: 300, height: 200)
    }
}

#Preview {
    VideoPlayerView()
}
