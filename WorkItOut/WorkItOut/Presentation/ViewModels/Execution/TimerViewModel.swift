//
//  TimerViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 26/10/23.
//

import Foundation

class TimerViewModel: ObservableObject {
    @Published var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @Published var timeRemaining: Double = 0
    @Published var timeToggle = false
    @Published var timeSet = 0
    
    init(seconds : Double = 60) {
        self.timeRemaining = seconds
    }
    
    func currentTime() -> String {
        return timeString(time: timeRemaining)
    }
    
    func startTimer() {
        timeToggle = true
        timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        timeSet = Int(timeRemaining/60)
    }
    
    func updateCurrentTime() {
        guard timeToggle else {return}
        
        if timeRemaining > 0 {
            timeRemaining -= 0.01
        }else{
            timer.upstream.connect().cancel()
            timeToggle.toggle()
        }
    }
    
    func timeString(time: Double) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i.%02i", minutes, seconds)
    }
    
}
