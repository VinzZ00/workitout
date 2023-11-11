//
//  HistoryCard.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 02/11/23.
//

import SwiftUI

struct HistoryCard: View {
    var history : History
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8){
                // MARK: Menghapus first karena udh bukan array. supaya tidak error.
                Text("\(history.yogaDone.name )")
                    .bold()
                Text("\(history.yogaDone.poses.count ) Exercise (\(history.duration) Min)")
                    .padding(.vertical, 2)
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
                .stroke(Color.neutral6)
        )
    }
}

//#Preview {
//    HistoryCard(history: History(id: UUID(), yogaDone: [], executionDate: Date.now, duration: 60, rating: 5))
//}
