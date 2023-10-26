//
//  WatchConnectivityHelper.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 26/10/23.
//

import Foundation
import WatchConnectivity

class WatchConnectivityHelper : NSObject, WCSessionDelegate, ObservableObject {
    var session : WCSession
    @Published var message : String = ""
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .notActivated:
            print("WCSession Not Activated")
        case .inactive:
            print("WCSession Inactive")
        case .activated:
            print("WCSession Activated")
        @unknown default:
            print("Unknown Error in WCSession")
        }
        if let error = error {
            print(error)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.message = message["message"] as? String ?? "No Value"
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func sendMessage(message: String){
        session.sendMessage(["message" : message], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
}
