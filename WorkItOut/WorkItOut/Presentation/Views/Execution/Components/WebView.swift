//
//  WebView.swift
//  Mamaste
//
//  Created by Kevin Dallian on 19/11/23.
//

import Foundation
import SwiftUI
import WebKit

class WebViewModel : ObservableObject {
    @Published var url : URL
    @Binding var isLoading : Bool
    init(url : URL, isLoading : Binding<Bool>) {
        self.url = url
        self._isLoading = isLoading
    }
}

struct WebView : UIViewRepresentable {
    @ObservedObject var vm : WebViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.allowsAirPlayForMediaPlayback = true
        webConfiguration.allowsPictureInPictureMediaPlayback = true
        
        var webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: vm.url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var vm: WebViewModel

        init(_ viewModel: WebViewModel) {
            self.vm = viewModel
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            withAnimation(.easeInOut) {
                vm.isLoading = false
            }
            
        }
    }

    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(vm)
    }
}
