//
//  CompleteView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 25/10/23.
//

import SwiftUI

struct CompleteView: View {
    var stringConstant = Constant.String.Onboarding.CompleteView.self
    var counter: Double = 0.75
    
    var body: some View {
        var strings: [Double : String] = [
            1.5 : stringConstant.Strings.first.stringValue(),
            1 : stringConstant.Strings.second.stringValue(),
            0.5 : stringConstant.Strings.third.stringValue(),
        ]
        
        ZStack {
            VStack {
                Image("AssesmentBackground")
                Spacer()
            }
            VStack {
                Text(stringConstant.title)
                    .font(.title.bold())
                Text(stringConstant.desc)
                    .frame(width: 240)
                    .multilineTextAlignment(.center)
                LoadingCircle()
                    .padding(96)
                Text(strings[counter] ?? strings.randomElement()!.value)
                    .frame(width: 240)
                    .multilineTextAlignment(.center)
                
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CompleteView()
}
