//
//  Rest.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 20/11/23.
//

import Foundation

enum HttpError : Error {
    case BadRequest
    case ServerError
    case NotFoundError
    case unknownError(Int)
}


class RESTRequest {
    var baseUrl : URL
    
    init(baseUrl : URL) {
        self.baseUrl = baseUrl
    }
    
    func httpGet(endPoint : String) async -> Result<[String : String], Error> {
        let endpointURL = self.baseUrl.appending(path: endPoint);
        var (data, resp) : (Data, URLResponse);
        
        do {
            (data, resp) = try await URLSession.shared.data(from: endpointURL)
        } catch let err {
            fatalError("Error in http get request to endpoint : \(endpointURL.absoluteString) with error : \(err.localizedDescription)")
        }
        
        guard let httpResp = resp as? HTTPURLResponse else {
            return .failure(HttpError.unknownError(<#T##Int#>))
        }
        
        
        if (200...299).contains(httpResp.statusCode) {
            do {
                guard let decodedData = try JSONSerialization.jsonObject(with: data) as? [String : String] else {
                    fatalError("nil returned decoding data into [String : String");
                }
                return .success(decodedData)
            } catch {
                fatalError("Error in decoding data into [String : String");
            }
        }
//        let task = URLSession.shared.dataTask(with: endpointURL) { data, resp, err in
//            if let err = err {
//                fatalError("Error in fetching data with error : \(err.localizedDescription)")
//            }
//            
//            guard let httpResp = resp as? HTTPURLResponse else {
//                fatalError("Error the response is nil")
//            }
//        
//            if (200...299).contains(httpResp.statusCode) {
//                do {
//                    if let data = data {
//                        if let decodedData = JSONSerialization.jsonObject(with: data, options: [], ) as? [String : String] {
//                            return .
//                        }
//                    }
//                }
//            }
//        }
    }
    
}
