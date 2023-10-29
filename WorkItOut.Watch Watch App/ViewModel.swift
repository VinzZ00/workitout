//
//  ViewModel.swift
//  WorkItOut.Watch Watch App
//
//  Created by Kevin Dallian on 27/10/23.
//

import Foundation
import WatchConnectivity

class ViewModel : NSObject, ObservableObject, WCSessionDelegate{
    @Published var pause : Bool = false
    @Published var heartRateManager = HeartRateManager()
    private var session : WCSession
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .notActivated:
            print("Watch Session Not Activated")
        case .inactive:
            print("Watch Session InActive")
        case .activated:
            print("Watch Session Activated")
        @unknown default:
            print("Unknown Error")
        }
    }
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func sendDataToPhone(key: String, message : Any) {
        let data = [key : message]
        session.sendMessage(data, replyHandler: nil)
    }
    
    func tappedPauseButton(){
        self.pause.toggle()
        self.sendDataToPhone(key: WatchConnectivityConstants.restart, message: self.pause)
    }
    
    func skipButton(){
        self.sendDataToPhone(key: WatchConnectivityConstants.skip, message: "Skip")
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any]) {
        // Handle the data received from the iPhone app.
    }
}
