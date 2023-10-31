//
//  AssessmentResultView.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 25/10/23.
//

import SwiftUI

struct AssessmentResultView: View {
    
    init(
        yogaPlan : Binding<YogaPlan>)
    {
        self._yogaPlan = yogaPlan;
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .orangePrimary
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        
        let backbutApp = UIBarButtonItemAppearance()
        backbutApp.normal.titleTextAttributes = [
            .foregroundColor : UIColor.white
        ]
        
        appearance.backButtonAppearance = backbutApp
        appearance.largeTitleTextAttributes =  [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @Binding var yogaPlan : YogaPlan;
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(yogaPlan.yogas) { yoga in
                        //                        DayAssessment(exercises: yoga.poses, day: 0, bodyPart: "Upper Body", weekday: "Text", timeOfDay: "Belom tau") {
                        //                            print("Button Next telah ditekan dari closure")
                    }
                    .padding(.top, 16)
                    
                    Divider()
                }
            }
            
            .navigationTitle("Workout Plan for Beginner")
            .toolbar(content: {
                Text("Save")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            })
            .navigationBarTitleDisplayMode(.large)
            
            Spacer()
            
            //Bottom Bar
            
            VStack {
                Spacer()
                Button("Next") {
                    
                }.buttonStyle(BorderedButton())
                Spacer()
            }.frame(height: 72)
        }
    }
}


#Preview {
    AssessmentResultView(yogaPlan: .constant(YogaPlan()))
}
