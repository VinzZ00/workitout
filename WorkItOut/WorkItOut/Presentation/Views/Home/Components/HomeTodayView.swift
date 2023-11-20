//
//  HomeTodayView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 19/11/23.
//

import SwiftUI

struct HomeTodayView: View {
    var body: some View {
        VStack {
            HeaderTodayView()
            Spacer()
            TodayBodyView()
            Spacer()
        }
    }
}

#Preview {
    HomeTodayView()
}
