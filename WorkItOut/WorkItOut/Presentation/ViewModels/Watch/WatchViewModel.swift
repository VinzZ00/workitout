//
//  WatchViewModel.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 27/10/23.
//

import Foundation
import WatchConnectivity

class WatchViewModel : NSObject, ObservableObject, WCSessionDelegate {
    
    private var session : WCSession
    @Published var message : String = ""
    @Published var restart : Bool = false
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .notActivated:
            print("Iphone Session not Activated")
        case .inactive:
            print("Iphone Session is inactive")
        case .activated:
            print("Iphone Session is activated")
        @unknown default:
            print("Unknown Error")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        messageHandler(message: message)
    }
    
    private func messageHandler(message : [String : Any]){
        if let heartRate = message[WatchConnectivityConstants.heartRate]{
            DispatchQueue.main.async {
                self.message = heartRate as! String
            }
        }
        if let restart = message[WatchConnectivityConstants.restart]{
            DispatchQueue.main.async{
                self.restart = restart as! Bool
            }
        }
        if let skip = message[WatchConnectivityConstants.skip]{
            print("Skip")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}
