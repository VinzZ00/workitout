//
//  HistoryViewModel.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 02/11/23.
//

import Foundation

class HistoryViewModel : ObservableObject {
    @Published var histories : [History] = []
    @Published var historiesWithDate : [Date : [History]] = [Date: [History]]()
    @Published var currentHistory : History?
    
    init(){
        // Ganti dengan load history dari coredata
        let poses = [
            Pose(id: UUID(), name: "Banana", description: "Banana", seconds: 60, state: .completed, position: .supine, spineMovement: .lateralBend, recommendedTrimester: .all, bodyPartTrained: [.back, .chest, .core], relieve: [.backpain, .neckcramp, .hippain], difficulty: .beginner),
            Pose(id: UUID(), name: "Bound Angle", description: "Bound Angle", seconds: 60, state: .completed, position: .seated, spineMovement: .neutral, recommendedTrimester: .second, bodyPartTrained: [.shoulders, .legs], relieve: [.hippain, .backpain, .pelvicflexibility], difficulty: .beginner),
            Pose(id: UUID(), name: "Gracious Pose", description: "Gracious Pose", seconds: 60, state: .notCompleted, position: .seated, spineMovement: .neutral, recommendedTrimester: .all, bodyPartTrained: [.shoulders, .legs], relieve: [.hippain, .backpain], difficulty: .beginner),
            Pose(id: UUID(), name: "Cat", description: "Cat", seconds: 60, state: .skipped, position: .armLegSupport, spineMovement: .forwardBend, recommendedTrimester: .first, bodyPartTrained: [.back, .neck], relieve: [.backpain, .pelvicflexibility], difficulty: .beginner)
        
        ]
        let yoga = Yoga(id: UUID(), name: "Day 1 - Upper Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga1 = Yoga(id: UUID(), name: "Day 2 - Lower Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga2 = Yoga(id: UUID(), name: "Day 3 - Core Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga3 = Yoga(id: UUID(), name: "Day 4 - Upper Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        self.histories.append(History(id: UUID(), yogaDone: [yoga], executionDate: Date.now, duration: 10, rating: 5))
        self.histories.append(History(id: UUID(), yogaDone: [yoga1], executionDate: Date.now, duration: 10, rating: 5))
        self.histories.append(History(id: UUID(), yogaDone: [yoga2], executionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, duration: 10, rating: 5))
        self.histories.append(History(id: UUID(), yogaDone: [yoga3], executionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, duration: 10, rating: 5))
        self.historiesWithDate = categorizeHistoryByDate(histories)
    }
    
    private func categorizeHistoryByDate(_ histories : [History]) -> [Date: [History]]{
        var categorizedHistories = [Date: [History]]()
        for history in histories {
            let date = history.executionDate
            
            let day = Calendar.current.component(.day, from: date)
            let dayDate = Calendar.current.date(from: DateComponents(day: day))!
            
            if categorizedHistories[dayDate] == nil{
                categorizedHistories[dayDate] = []
            }
            
            categorizedHistories[dayDate]?.append(history)
        }
        return categorizedHistories
    }
}
