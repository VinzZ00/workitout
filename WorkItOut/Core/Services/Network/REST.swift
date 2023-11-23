//
//  Rest.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 20/11/23.
//

import Foundation

// unknown error Notes :
/*
 -100 = URL session Error tidak dapat dijalankan (check Connection, or url)
 -99 = gaad response
 -
 other than that should be based on the httpresp if not in 200 - 299
 */

enum HttpError : Error {
    case BadRequest
    case ServerError
    case NotFoundError
    case unknownError(Int)
}


class RESTRequest {
    var baseUrl : URL
    
    init(host : String, endPoint : String, param : [String : String]) throws {
        var urlComponent = URLComponents()
        
        urlComponent.scheme = "https"
        urlComponent.host = host
        urlComponent.path = endPoint
        urlComponent.queryItems =
            param.map{ URLQueryItem(name: $0.key, value: $0.value)}
        
        if let url = urlComponent.url {
            self.baseUrl = url
        } else {
            throw NSError(domain: "url not valid", code: -101)
        }
    }
    
    func httpGet() async -> Result<[String : String], Error> {
        
        var (data, resp) : (Data, URLResponse);
        
        do {
            (data, resp) = try await URLSession.shared.data(from: baseUrl)
        } catch let err {
            return .failure(NSError(domain: "Error in hitting url endpoint with error : \(err.localizedDescription)", code: -100))
        }
        
        guard let httpResp = resp as? HTTPURLResponse else {
            return .failure(HttpError.unknownError(-99));
        }
        
        
        if (200...299).contains(httpResp.statusCode) {
            do {
                guard let decodedData = try JSONSerialization.jsonObject(with: data) as? [String : String] else {
                    fatalError("nil returned decoding data into [String : String");
                }
                return .success(decodedData)
            } catch let err{
                return .failure(NSError(domain: "Error in decoding data into [String : String] with error desc : \(err.localizedDescription)", code: httpResp.statusCode))
            }
        } else {
            return .failure(HttpError.unknownError(httpResp.statusCode))
        }
    }
    
    
}
