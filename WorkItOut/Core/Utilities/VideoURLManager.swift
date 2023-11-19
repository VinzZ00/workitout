//
//  URLManager.swift
//  Mamaste
//
//  Created by Kevin Dallian on 19/11/23.
//

import Foundation

struct VideoURLManager {
    var scheme = "https"
    var youtubeHost = "www.youtube.com"
    
    func generateURL(videoID: String) -> URL {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.youtubeHost
        components.path = "/embed/\(videoID)"
        components.queryItems = [
            URLQueryItem(name: "loop", value: "1"),
            URLQueryItem(name: "autoplay", value: "1"),
            URLQueryItem(name: "playlist", value: videoID)
        ]
        return components.url!
    }
}
