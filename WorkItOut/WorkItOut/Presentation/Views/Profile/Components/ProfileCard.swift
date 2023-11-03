//
//  ProfileCard.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import SwiftUI

struct ProfileCard: View {
    var detail : (String, String)
    var value : String
    init(assessmentState: AssessmentState, value: String) {
//        detail = assessmentState.getDescription()
        detail = ("Test Detail", "Test Detail")
        self.value = value
    }
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("\(detail.0)")
                    .bold()
                Text("\(detail.1)")
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                Text("\(value)")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                    .lineLimit(1)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.grayBorder)
        )
    }
}

#Preview {
    ProfileCard(assessmentState: .chooseDay, value: "Weeks 12(Trimester 1)")
}
