//
//  OnboardingView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 10/11/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var getStarted: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                Text("Welcome to Mamaste")
                    .font(.largeTitle)
                    .bold()
                Text("Your personalized yoga guide for a healthy pregnancy")
                ButtonComponent(title: "Get Started") {
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
