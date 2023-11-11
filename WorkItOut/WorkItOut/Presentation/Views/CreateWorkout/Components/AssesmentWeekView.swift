//
//  AssesmentWeekView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 02/11/23.
//

import SwiftUI

struct AssesmentWeekView: View {
    @Binding var week: Int
    
    var body: some View {
        VStack {
            Text("What weeks of pregnancy are you in?")
                .font(.title).bold()
            Picker("Week Picker", selection: $week) {
                ForEach(0...40, id: \.self) { i in
                    Text("Week \(i)").tag(i)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

#Preview {
    AssesmentWeekView(week: .constant(10))
}
