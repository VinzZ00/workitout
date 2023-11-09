//
//  Video.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 07/11/23.
//

import SwiftUI
import AVKit

extension AVPlayerViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.showsPlaybackControls = false
    }
}
