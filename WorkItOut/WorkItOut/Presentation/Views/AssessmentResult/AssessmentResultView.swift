//
//  AssessmentResultView.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 25/10/23.
//

import SwiftUI

struct AssessmentResultView: View {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        
        appearance.largeTitleTextAttributes =  [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
            }
            .background(.orange)
            .navigationTitle("Workout Plan for Beginner")
            
            .navigationBarTitleDisplayMode(.large)
            

            
                
        }
    }
}

#Preview {
    AssessmentResultView()
}
