//
//  OnboardingView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 10/11/23.
//

import SwiftUI

struct OnboardingView: View {
    let stringConstant = Constant.String.Onboarding.OnboardingView.self
    @State var getStarted: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                Text(stringConstant.title)
                    .font(.largeTitle)
                    .bold()
                Text(stringConstant.desc)
                ButtonComponent(title: stringConstant.button.stringValue()) {
                    getStarted = true
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 48)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .background {
                Image("OnboardingBackground")
                    .resizable()
            }
            .ignoresSafeArea()
            .navigationDestination(isPresented: $getStarted) {
                UserConsentView()
            }
        }
        
        
        
    }
}

#Preview {
    OnboardingView()
}
