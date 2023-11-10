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
    var displayDate : Date
    var calendar : Calendar!
    
    init(selectedDay: Binding<Day>, workoutDay: [Day], day: Day, weekXpreg : Int, checkedWeek : Int) {
        self.calendar = Calendar.current
        self._selectedDay = selectedDay
        self.workoutDay = workoutDay
        self.day = day
        
        var DisplayWeek = checkedWeek - weekXpreg;
        
        // MARK: TO GET THE CURRENT WEEK OF THE YEAR
        let currentDate = Date()
        let pregDate = self.calendar.date(byAdding: .weekOfYear, value: -weekXpreg, to: currentDate)
        let weekOfPreg = self.calendar.dateComponents([.weekOfYear], from: pregDate!)
        let woy = weekXpreg + weekOfPreg.weekOfYear! + DisplayWeek
        
        // MARK: TO GET CURRENT YEAR
        let year = self.calendar.dateComponents([.year], from: currentDate).year!
        
        // MARK: TO GET THE CURRENT DATE OF THE WEEKDAY
        self.displayDate = day.dateForWeekday(week: woy, year: year);
    }
    
    var body: some View {
        Button(action: {
            selectedDay = day
        }, label: {
            VStack {
                Text(day.getShortenedDay())
                    .foregroundStyle(Color.neutral3.opacity(0.75))
                VStack {
                    Text("\(self.calendar.dateComponents([.day], from: displayDate).day!)")
                        .foregroundStyle(day == selectedDay ? Color.primary : .black)
                        .frame(maxWidth: 24)
                    Circle()
                        .foregroundStyle(Color.primary)
                        .frame(width: 4)
                        .opacity(workoutDay.contains(where: {$0 == day}) ? 1 : 0)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(day == selectedDay ? Color.primary.opacity(0.25) : .clear)
                    .stroke(day == selectedDay ? Color.primary : .clear, lineWidth: 1)
                )
            }
        })
        
        
    }
}

//#Preview {
//    DayButtonView(selectedDay: .constant(.friday), workoutDay: [.friday, .saturday, .sunday], day: .friday, weekXpreg: 20, checkedWeek: 20)
//}
