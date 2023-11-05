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
    @Published var isTimerPaused = false
    @Published var timeToggle : Bool = false
    @Published var timeSet = 0
    @Published var timesUp = false
    
    func currentTime() -> String {
        return timeString(time: timeRemaining)
    }
    
    func startTimer(time: Double) {
        timeToggle = true
        timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        timeSet = Int(time/60)
        timeRemaining = time
    }
    
    func updateCurrentTime() {
        guard timeToggle else {return}
        
        if timeRemaining > 0 {
            timeRemaining -= 0.01
        }else{
            timer.upstream.connect().cancel()
            timeToggle.toggle()
            timesUp = true
        }
    }
    
    func resetTimer(time: Double) {
        timeToggle = false
        timer.upstream.connect().cancel()
        timeRemaining = time
    }
    
    func pauseTimer() {
        isTimerPaused = true
        timer.upstream.connect().cancel()
    }
    
    func continueTimer() {
        isTimerPaused = false
        timeToggle = true
        timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
    
    func timeString(time: Double) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
}
