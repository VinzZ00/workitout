//
//  NotificationView.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 29/10/23.
//

import SwiftUI

struct NotificationView: View {
    var dateList = ["09/10/2023", "10/10/2023", "11/10/2023", "12/10/2023"]
    @State private var workoutDate = ""
    @State private var currentDate = ""
    
    var vm = NotificationViewModel()
    
    var body: some View {
        VStack (spacing: 40) {
            HStack {
                Text("Workout Date:")
                Picker("Workout Date", selection: $workoutDate) {
                    ForEach(dateList, id: \.self) {
                    Text($0)
                    }
                }.pickerStyle(.wheel)
            }
            
            HStack {
                Text("Current Date:")
                Picker("Current Date", selection: $currentDate) {
                    ForEach(dateList, id: \.self) {
                    Text($0)
                    }
                }.pickerStyle(.wheel)
            }
            
        }.onAppear {
            vm.requestAuthorization()
            
        }
        .onChange(of: currentDate) { _, newDate in
            if newDate == workoutDate{
                vm.makeNotification(title: "Workout", subtitle: "Today is your schedule to workout")
            }
        }
    }
}

#Preview {
    NotificationView()
}
