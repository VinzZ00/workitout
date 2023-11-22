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
    let APIService = RESTRequest(baseUrl: URL(string: "https://api.i18nexus.com/project_resources/translations")!)
    var nameSpace = "default.json"
    var param = "api_key=0tiYnNwaoQHnoQcktDcqHw"
    
    func getLangResource(lang : String, poseNames : [String]) async -> Result<[String : String], Error> {
        
        APIService.baseUrl = APIService.baseUrl.appending(path: "en/\(nameSpace)?\(param)")
        print("apiservice baseURL : \(APIService.baseUrl)")
        
        switch await APIService.httpGet(endPoint: "en/\(nameSpace)?\(param)") {
        case .success(let returnedData) :
            return .success(returnedData.filter{ poseNames.contains($0.key) })
        case .failure(let err) :
            return .failure(err)
        }
        
    }
    
}
