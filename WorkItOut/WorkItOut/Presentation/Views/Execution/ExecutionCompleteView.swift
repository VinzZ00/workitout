//
//  ExecutionCompleteView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 03/11/23.
//

import SwiftUI

struct ExecutionCompleteView: View {
    var body: some View {
        VStack(spacing: 60){
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 120, height: 120)
                Text("Placeholder")
                    .foregroundStyle(.white)
            }
            VStack{
                Text("Exercise Completed")
                    .font(.title.bold())
                Text("Yeayy, you made it! You have completed today yoga.")
                    .bold()
                    .frame(width: 350)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            Button("Back to Home"){
                print("Back to home")
            }.buttonStyle(BorderedButton())
        }
    }
}

#Preview {
    ExecutionCompleteView()
}
