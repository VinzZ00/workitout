//
//  DayButtonView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

enum DayButtonEnum {
    case none
    case filled
    case current
}

struct DayButtonView: View {
    @State var state: DayButtonEnum = .current
    
    var body: some View {
        VStack {
            Text("Sun")
                .foregroundStyle(.orangePrimary)
            VStack {
                Text("4")
                if state == .filled || state == .current {
                    Circle()
                        .foregroundStyle(.orangePrimary)
                        .frame(width: 4)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 12)
                .fill(state == .current ? .orangePrimary.opacity(0.25) : .clear)
                .stroke(state == .current ? .orangePrimary : .grayBorder, lineWidth: 1)
            )
        }
        
    }
}

#Preview {
    DayButtonView()
}
