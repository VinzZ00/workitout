//
//  AssessmentDetailView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import SwiftUI

struct AssessmentDetailView<E: UserPreference>: View {
    var title : String
    @Binding var selection : E
    @State var selections : [E]
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title).bold()
            ForEach(selections, id: \.self){ selection in
                Button(action: {self.selection = selection}, label: {
                    HStack{
                        Text(selection.getString())
                            .font(.body.bold())
                            .padding(.leading, 10)
                            .padding(.vertical, 15)
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(selection == self.selection ? Color.primary.opacity(0.25) : .clear)
                        .stroke(selection == self.selection ? Color.primary : Color.neutral6, lineWidth: 1)
                    )
                })
                .padding(.vertical, 3)
            }
        }
    }
}

//#Preview {
//    AssessmentDetailView(title: "On the days you're available, what times work best for you?", selection: .constant("Morning"), selections: TimeClock.allCases.map({$0.rawValue}))
//}
