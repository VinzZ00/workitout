//
//  WebView.swift
//  Mamaste
//
//  Created by Kevin Dallian on 19/11/23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.allowsAirPlayForMediaPlayback = true
        webConfiguration.allowsPictureInPictureMediaPlayback = true
        
        var webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.sizeToFit()
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

