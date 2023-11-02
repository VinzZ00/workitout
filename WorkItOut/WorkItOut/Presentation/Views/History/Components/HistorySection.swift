//
//  HistorySection.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 02/11/23.
//

import SwiftUI

struct HistorySection: View {
    var date : Date
    var histories : [History]
    var body: some View {
        VStack(alignment: .leading){
            Text(date.formatted(date: .complete, time: .omitted))
                .bold()
                .foregroundStyle(.gray)
            ForEach(histories, id: \.id){ history in
                HistoryCard(history: history)
            }
            
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    HistorySection(date: Date.now, histories: [])
}
