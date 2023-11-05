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
            Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.ankle, .back, .hip], description: "Banana", seconds: 60, state: .completed, position: .supine, spineMovement: .lateralBend, bodyPartTrained: [.back, .chest, .core]),
            Pose(id: UUID(), name: "Bound Angle", difficulty: .beginner, recommendedTrimester: .second, relieve: [.ankle, .back, .hip], description: "Bound Angle", seconds: 60, state: .completed, position: .seated, spineMovement: .neutral, bodyPartTrained: [.shoulders, .legs]),
            Pose(id: UUID(), name: "Gracious Pose", difficulty: .beginner, recommendedTrimester: .all, relieve: [.ankle, .back, .hip], description: "Gracious Pose", seconds: 60, state: .notCompleted, position: .seated, spineMovement: .neutral, bodyPartTrained: [.shoulders, .legs]),
            Pose(id: UUID(), name: "Cat", difficulty: .beginner, recommendedTrimester: .first, relieve: [.ankle, .back, .hip], description: "Cat", seconds: 60, state: .skipped, position: .armLegSupport, spineMovement: .forwardBend, bodyPartTrained: [.back, .neck])
        
        ]
        let yoga = Yoga(id: UUID(), name: "Day 1 - Upper Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga1 = Yoga(id: UUID(), name: "Day 2 - Lower Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga2 = Yoga(id: UUID(), name: "Day 3 - Core Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga3 = Yoga(id: UUID(), name: "Day 4 - Upper Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        
        // MARK: Menghapus [] pada yoga sampai yoga 3 by Elvin 4 Nov
        
        self.histories.append(History(id: UUID(), yogaDone: yoga, executionDate: Date.now, duration: 10, rating: 5))
        self.histories.append(History(id: UUID(), yogaDone: yoga1, executionDate: Date.now, duration: 10, rating: 5))
        self.histories.append(History(id: UUID(), yogaDone: yoga2, executionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, duration: 10, rating: 5))
        self.histories.append(History(id: UUID(), yogaDone: yoga3, executionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, duration: 10, rating: 5))
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
