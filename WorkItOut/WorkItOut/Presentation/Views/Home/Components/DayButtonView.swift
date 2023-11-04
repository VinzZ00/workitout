//
//  DayButtonView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct DayButtonView: View {
    @Binding var selectedDay: Day
    var days: [Day] = [.monday, .tuesday, .thursday]
    var day: Day = .monday
    
    var body: some View {
        Button(action: {
            selectedDay = day
        }, label: {
            VStack {
                Text(day.getShortenedDay())
                    .foregroundStyle(Color.neutral3.opacity(0.75))
                VStack {
                    Text("\(day.getWeekdayInInt())")
                        .foregroundStyle(day == selectedDay ? Color.primary : .black)
                    Circle()
                        .foregroundStyle(Color.primary)
                        .frame(width: 4)
                        .opacity(days.contains(where: {$0 == day}) ? 1 : 0)
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
