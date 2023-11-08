//
//  Video.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 07/11/23.
//

import SwiftUI
import AVKit

struct AVPlayerController : UIViewControllerRepresentable {
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}
