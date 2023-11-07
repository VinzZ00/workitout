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
    
    init(histories : [History]){
        if histories.isEmpty {
            
        }else {
            self.histories = histories
            self.historiesWithDate = categorizeHistoryByDate(self.histories)
        }
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
