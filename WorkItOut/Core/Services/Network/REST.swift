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
    
    init(baseUrl : URL) {
        self.baseUrl = baseUrl
    }
    
    func httpGet(endPoint : String) async -> Result<[String : String], Error> {
        let endpointURL = self.baseUrl.appending(path: endPoint);
        var (data, resp) : (Data, URLResponse);
        
        do {
            (data, resp) = try await URLSession.shared.data(from: endpointURL)
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
