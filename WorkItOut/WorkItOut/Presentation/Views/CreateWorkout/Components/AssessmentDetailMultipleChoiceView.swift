//
//  AssessmentDetailMultipleChoiceView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import SwiftUI

struct AssessmentDetailMultipleChoiceView<E: UserPreference>: View {
    var title : String
    @Binding var selectedItems : [E]
    @State var selections : [E]
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title).bold()
            Text("(Check all that apply)")
                .font(.headline)
                .foregroundStyle(.gray)
            ForEach($selections, id: \.self){ selection in
                Button(action: {
                    if selectedItems.contains(selection.wrappedValue){
                        guard let selectedIndex = selectedItems.firstIndex(of: selection.wrappedValue) else {
                            return
                        }
                        selectedItems.remove(at: selectedIndex)
                    }else{
                        selectedItems.append(selection.wrappedValue)
                    }
                }, label: {
                    HStack{
                        Text(selection.wrappedValue.getString())
                            .font(.body.bold())
                            .padding(.leading, 10)
                            .padding(.vertical, 15)
                        Spacer()
                    }
                    .tint(.primary)
                    .background(self.selectedItems.contains(selection.wrappedValue) ? .orangePrimary : .clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(self.selectedItems.contains(selection.wrappedValue) ? .orangePrimary : .grayBorder, lineWidth: 2)
                    )
                })
                .padding(.vertical, 3)
            }
        }
    }
}

//#Preview {
//    AssessmentDetailMultipleChoiceView(title: "Which days of the week are you available for exercise? ", selectedItems: .constant(["Monday", "Wednesday", "Friday"]), selections: Day.allCases.map({$0.rawValue}))
//}
