//
//  StateIndicator.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 25/10/23.
//

import SwiftUI

struct StateIndicator: View {
    @Binding var state : AssessmentState
    var body: some View {
        HStack{
            ForEach(0..<AssessmentState.allCases.count-1){ idx in
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(idx < state.rawValue ? Color.primary : .gray)
                    .frame(width: 36, height: 4)
            }
        }
    }
}

#Preview {
    StateIndicator(state: .constant(.chooseDay))
}
