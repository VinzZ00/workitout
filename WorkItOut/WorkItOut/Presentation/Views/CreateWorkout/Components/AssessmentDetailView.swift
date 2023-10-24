//
//  AssessmentDetailView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import SwiftUI

struct AssessmentDetailView: View {
    var title : String
    @Binding var selection : String
    @State var selections : [String]
    
    var body: some View {
        VStack{
            Text(title)
                .font(.title).bold()
            ForEach(selections, id: \.self){ selection in
                Button(action: {self.selection = selection}, label: {
                    HStack{
                        Text(selection)
                            .font(.body.bold())
                            .padding(.leading, 10)
                            .padding(.vertical, 15)
                        Spacer()
                    }
                    .tint(.primary)
                    .background(selection == self.selection ? .orangeBackground : .clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selection == self.selection ? .orangePrimary : .grayBorder, lineWidth: 2)
                    )
                })
                .padding(.vertical, 3)
            }
        }
    }
}

#Preview {
    AssessmentDetailView(title: "On the days you're available, what times work best for you?", selection: .constant("Morning"), selections: TimeClock.allCases.map({$0.rawValue}))
}
