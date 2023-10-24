//
//  WorkoutDayView.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import SwiftUI

struct WorkoutDayView: View {
    @EnvironmentObject var vm: GenerateWorkoutViewModel
    @State var day: Day = .friday
    
    var body: some View {
        List(vm.workoutWeekday[day]!.exercises, id: \.self) { exercise in
            NavigationLink(exercise.name) {
                EditExerciseView(evm: EditExerciseViewModel(day: day, exercise: exercise))
                    .environmentObject(vm)
            }
        }
        .navigationTitle("Exercise List")
    }
}

#Preview {
    WorkoutDayView()
}
