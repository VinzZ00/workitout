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
                Text("Sun")
                    .foregroundStyle(Color.primary)
                VStack {
                    Text("4")
                    Circle()
                        .foregroundStyle(Color.primary)
                        .frame(width: 4)
                        .opacity(days.contains(where: {$0 == day}) ? 1 : 0)
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(day == selectedDay ? Color.primary.opacity(0.25) : .clear)
                    .stroke(day == selectedDay ? Color.primary : Color.neutral3, lineWidth: 1)
                )
            }
        })
        
        
    }
}

//#Preview {
//    DayButtonView()
//}
