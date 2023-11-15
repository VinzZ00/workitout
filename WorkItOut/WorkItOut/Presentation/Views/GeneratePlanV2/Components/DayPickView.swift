//
//  DayPickView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 02/11/23.
//

import SwiftUI

struct DayPickView: View {
    @EnvironmentObject var vm: GeneratePlanViewModel
    @Binding var selected: Day
    var day: Day = .monday
    
    var body: some View {
        VStack {
            Button(action: {
                vm.scrollTarget = day.getInt()
                selected = day
            }, label: {
                VStack {
                    Text(day.getString())
                        .bold()
                    Rectangle()
                        .frame(height: 4)
                        .padding(0)
                        .foregroundStyle(selected == day ? Color.primary : .neutral6)
                }
            })
            .buttonStyle(.plain)
        }
    }
}

//#Preview {
//    DayPickView(selected: .constant(.monday))
//}
