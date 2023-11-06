//
//  AssessmentDetailMultipleChoiceView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import SwiftUI

struct AssessmentDetailMultipleChoiceView<E: UserPreference>: View {
    var title : String
    var explanation: String = "(Check all that apply)"
    @Binding var selectedItems : [E]
    @State var selections : [E]
    
    var limit: Int = 0
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title).bold()
            Text(explanation)
                .font(.headline)
                .foregroundStyle(.gray)
            ScrollView {
                ForEach($selections, id: \.self){ selection in
                    Button(action: {
                        if selectedItems.contains(selection.wrappedValue){
                            guard let selectedIndex = selectedItems.firstIndex(of: selection.wrappedValue) else {
                                return
                            }
                            selectedItems.remove(at: selectedIndex)
                        }else{
                            if limit == 0 {
                                selectedItems.append(selection.wrappedValue)
                            }
                            else if !(selectedItems.count >= limit) {
                                selectedItems.append(selection.wrappedValue)
                            }
                            
                        }
                    }, label: {
                        HStack{
                            Text(selection.wrappedValue.getString())
                                .font(.body.bold())
                                .padding(.leading, 10)
                                .padding(.vertical, 15)
                            Spacer()
                        }
                        
                    })
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(self.selectedItems.contains(selection.wrappedValue) ? .orangePrimary.opacity(0.25) : .clear)
                        .stroke(self.selectedItems.contains(selection.wrappedValue) ? .orangePrimary : .grayBorder, lineWidth: 1)
                    )
                    .padding(.vertical, 3)
                }

            }
        }
    }
}

//#Preview {
//    AssessmentDetailMultipleChoiceView(title: "Which days of the week are you available for exercise? ", selectedItems: .constant(["Monday", "Wednesday", "Friday"]), selections: Day.allCases.map({$0.rawValue}))
//}
