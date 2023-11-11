//
//  UserConsentView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 10/11/23.
//

import SwiftUI

struct UserConsentView: View {
    @State var next: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    Image("UserConsentIcon")
                    Text("Safety first")
                        .font(.largeTitle)
                        .bold()
                    Text("By continuing, I acknowledge that **I have consulted with my Doctor or healthcare provider** to ensure my pregnancy condition and my unique medical conditions and circumstances. My well-being and the safety of my baby are of the utmost importance.\n\n I consent to Mamaste **processing all data** I provide through this app, including sensitive data such as health information so that Mamaste can provide services to me.")
                    
                }
                .padding(.vertical)
                Spacer()
                ButtonComponent(title: "Agree and Continue") {
                    next = true
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                VStack {
                    Image("AssesmentBackground")
                    Spacer()
                }
                .ignoresSafeArea()
            )
            .navigationDestination(isPresented: $next) {
                AssessmentView()
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    UserConsentView()
}
