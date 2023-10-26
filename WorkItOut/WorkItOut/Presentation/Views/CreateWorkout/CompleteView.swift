//
//  CompleteView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 25/10/23.
//

import SwiftUI

struct CompleteView: View {
    var body: some View {
        VStack{
            LoadingCircle()
                .padding(.bottom, 20)
            Text("Creating Exercise Plan")
                .font(.title.bold())
            Text("Please wait, we are best exercise plan for you")
                .frame(width: 200)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CompleteView()
}
