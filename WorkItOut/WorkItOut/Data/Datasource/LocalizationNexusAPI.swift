//
//  LocalizationNexusAPI.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 22/11/23.
//

import Foundation

protocol NexusLocalizationAPIProtocol {
    func getLangResource(lang : String, poseNames : [String]) async -> Result<[String : String], Error>
}

class NexusLocalizationAPIDataSource : NexusLocalizationAPIProtocol {
    let APIService : RESTRequest;
//    var nameSpace = "default.json"
//    var param = ["api_key" : "0tiYnNwaoQHnoQcktDcqHw"]
    
    init() throws {
        self.APIService =  try RESTRequest(host: "api.i18nexus.com", endPoint: "/project_resources/translations/en/default.json", param: [
            "api_key" : "0tiYnNwaoQHnoQcktDcqHw"
        ])
    }
    
    func getLangResource(lang : String, poseNames : [String]) async -> Result<[String : String], Error> {
//        ?\(param)
//        APIService.baseUrl = APIService.baseUrl.appending(path: "en/\(nameSpace)")
//        
//        var urlComponent = URLComponents(string: APIService.baseUrl.absoluteString);
//        
//        var querryItem : [URLQueryItem] = [URLQueryItem]()
//        
//        for (k, val) in param {
//            querryItem.append(URLQueryItem(name: k, value: val))
//        }
//        
//        APIService.baseUrl = urlComponent!.url!
        
        
        print("apiservice baseURL : \(APIService.baseUrl)")
        
        switch await APIService.httpGet() {
        case .success(let returnedData) :
            return .success(returnedData.filter{ poseNames.contains($0.key) })
        case .failure(let err) :
            return .failure(err)
        }
        
    }
    
}
