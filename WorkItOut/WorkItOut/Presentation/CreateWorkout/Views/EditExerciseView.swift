//
//  EditExerciseView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 24/10/23.
//

import SwiftUI

struct EditExerciseView: View {
    @EnvironmentObject var vm: GenerateWorkoutViewModel
    @StateObject var evm: EditExerciseViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Picker("Exercise Picker", selection: $evm.exercisePicker) {
                ForEach(MockData.mockExercises, id: \.self) { exercise in
                    if exercise.muscleGroup == evm.exercise.muscleGroup {
                        Text(exercise.name).tag(exercise)
                    }
                }
            }
            .pickerStyle(.menu)
            SliderComponent(title: "Reps", value: $evm.reps, measurementUnit: "reps", minRange: 1, maxRange: 30)
            SliderComponent(title: "Sets", value: $evm.sets, measurementUnit: "sets", minRange: 1, maxRange: 10)
            
            ButtonComponent(title: "Edit") {
                vm.changeExercise(day: evm.day, exercise: evm.exercise, newExercise: evm.exercisePicker)
                
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

//#Preview {
//    EditExerciseView()
//}
