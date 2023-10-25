//
//  AssessmentDetailMultipleChoiceView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import SwiftUI

struct AssessmentDetailMultipleChoiceView: View {
    var title : String
    @Binding var selectedItems : [String]
    @State var selections : [String]
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title).bold()
            Text("(Check all that apply)")
                .font(.headline)
                .foregroundStyle(.gray)
            ForEach(selections, id: \.self){ selection in
                Button(action: {
                    if selectedItems.contains(selection){
                        guard let selectedIndex = selectedItems.firstIndex(of: selection) else {
                            return
                        }
                        selectedItems.remove(at: selectedIndex)
                    }else{
                        selectedItems.append(selection)
                    }
                }, label: {
                    HStack{
                        Text(selection)
                            .font(.body.bold())
                            .padding(.leading, 10)
                            .padding(.vertical, 15)
                        Spacer()
                    }
                    .tint(.primary)
                    .background(self.selectedItems.contains(selection) ? .orangeBackground : .clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(self.selectedItems.contains(selection) ? .orangePrimary : .grayBorder, lineWidth: 2)
                    )
                })
                .padding(.vertical, 3)
            }
        }
    }
}

#Preview {
    AssessmentDetailMultipleChoiceView(title: "Which days of the week are you available for exercise? ", selectedItems: .constant(["Monday", "Wednesday", "Friday"]), selections: Day.allCases.map({$0.rawValue}))
}
