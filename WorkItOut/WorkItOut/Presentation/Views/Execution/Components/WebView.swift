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
    var url : URL
    @ObservedObject var vm : ExecutionViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.allowsAirPlayForMediaPlayback = true
        webConfiguration.allowsPictureInPictureMediaPlayback = true
        
        var webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        webView.isUserInteractionEnabled = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if vm.videoIsLoading{
            if let desiredURL = vm.desiredVideoURL {
                let request = URLRequest(url: desiredURL)
                webView.load(request)
            }
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var videoIsLoading : Bool

        init(_ videoIsLoading : Binding<Bool>) {
            self._videoIsLoading = videoIsLoading
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            withAnimation(.easeInOut) {
                videoIsLoading = false
            }
        }
    }

    func makeCoordinator() -> WebView.Coordinator {
        Coordinator($vm.videoIsLoading)
    }
}
