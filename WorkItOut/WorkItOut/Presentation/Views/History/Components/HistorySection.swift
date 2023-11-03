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
    @Binding var showSheet : Bool
    @Binding var currentHistory : History?
    var body: some View {
        VStack(alignment: .leading){
            Text(date.formatted(date: .complete, time: .omitted))
                .bold()
                .foregroundStyle(.gray)
            ForEach(histories, id: \.id){ history in
                Button(action: {
                    currentHistory = history
                    showSheet.toggle()
                }, label: {
                    HistoryCard(history: history)
                })
            }
            
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    HistorySection(date: Date.now, histories: [], showSheet: .constant(false), currentHistory: .constant(nil))
}
