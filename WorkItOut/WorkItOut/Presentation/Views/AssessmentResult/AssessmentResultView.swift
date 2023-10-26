//
//  AssessmentResultView.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 25/10/23.
//

import SwiftUI

struct AssessmentResultView: View {
    
    init(
        workoutPlan : Binding<WorkoutPlan>)
    {
        self._workoutPlan = workoutPlan;
        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
        //        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
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
    
    @Binding var workoutPlan : WorkoutPlan;
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(workoutPlan.workouts) { workout in
                        DayAssessment(exercises: workout.exercises, day: workout.getDesiredDate(desired: [.day]).day!, bodyPart: "Upper Body", weekday: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"][workout.getDesiredDate(desired: [.weekday]).weekday!], timeOfDay: "Belom tau") {
                            print("Button Next telah ditekan dari closure")
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
}

#Preview {
    AssessmentResultView(workoutPlan: .constant(WorkoutPlan(workouts: [
        Workout(id: UUID(), exercises: [
            Exercise(name: "exercise 1", muscleGroup: [.arm, .chest], equipment: [.dumbbell], repetition: 12, workoutSet: 4),
            Exercise(name: "exercise 2", muscleGroup: [.arm, .chest], equipment: [.dumbbell], repetition: 12, workoutSet: 4),
            Exercise(name: "exercise 3", muscleGroup: [.arm, .chest], equipment: [.dumbbell], repetition: 12, workoutSet: 4)
        ], workoutState: .onProgress, date: .now),
        Workout(id: UUID(), exercises: [
            Exercise(name: "exercise 1", muscleGroup: [.arm, .chest], equipment: [.dumbbell], repetition: 12, workoutSet: 4),
            Exercise(name: "exercise 2", muscleGroup: [.arm, .chest], equipment: [.dumbbell], repetition: 12, workoutSet: 4),
            Exercise(name: "exercise 3", muscleGroup: [.arm, .chest], equipment: [.dumbbell], repetition: 12, workoutSet: 4)
        ], workoutState: .onProgress, date: .now),
        Workout(id: UUID(), exercises: [
            Exercise(name: "exercise 1", muscleGroup: [.arm, .chest], equipment: [.dumbbell], repetition: 12, workoutSet: 4),
            Exercise(name: "exercise 2", muscleGroup: [.arm, .chest], equipment: [.dumbbell], repetition: 12, workoutSet: 4),
            Exercise(name: "exercise 3", muscleGroup: [.arm, .chest], equipment: [.dumbbell], repetition: 12, workoutSet: 4)
        ], workoutState: .onProgress, date: .now)
    ])))
}
