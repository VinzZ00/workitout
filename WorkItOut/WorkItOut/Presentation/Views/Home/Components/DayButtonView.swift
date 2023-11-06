//
//  DayButtonView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct DayButtonView: View {
    @Binding var selectedDay: Day
    var workoutDay: [Day]
    var day: Day
    var currentDate : Date
    var calendar : Calendar!
    init(selectedDay: Binding<Day>, workoutDay: [Day], day: Day, startOfPregWeek : Int) {
        self.calendar = Calendar.current
        self._selectedDay = selectedDay
        self.workoutDay = workoutDay
        self.day = day
        
        // MARK: TO GET THE CURRENT WEEK OF THE YEAR
        let currentDate = Date()
        let pregDate = self.calendar.date(byAdding: .weekOfYear, value: -startOfPregWeek, to: currentDate)
        let weekOfPreg = self.calendar.dateComponents([.weekOfYear], from: pregDate!)
        let weekOfYear = startOfPregWeek + weekOfPreg.weekOfYear!
        
        // MARK: TO GET CURRENT YEAR
        let year = self.calendar.dateComponents([.year], from: currentDate).year!
        
        // MARK: TO GET THE CURRENT DATE OF THE WEEKDAY
        self.currentDate = day.dateForWeekday(week: weekOfYear, year: year);
    }
    
    var body: some View {
        Button(action: {
            selectedDay = day
        }, label: {
            VStack {
                Text(day.getShortenedDay())
                    .foregroundStyle(Color.neutral3.opacity(0.75))
                VStack {
                    Text("\(self.calendar.dateComponents([.day], from: currentDate).day!)")
                        .foregroundStyle(day == selectedDay ? Color.primary : .black)
                    Circle()
                        .foregroundStyle(Color.primary)
                        .frame(width: 4)
                        .opacity(workoutDay.contains(where: {$0 == day}) ? 1 : 0)
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(day == selectedDay ? Color.primary.opacity(0.25) : .clear)
                    .stroke(day == selectedDay ? Color.primary : .clear, lineWidth: 1)
                )
            }
        })
        
        
    }
}

//#Preview {
//    DayButtonView()
//}
