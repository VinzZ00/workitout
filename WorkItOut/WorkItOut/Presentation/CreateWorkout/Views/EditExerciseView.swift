//
//  EditExerciseView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 24/10/23.
//

import SwiftUI

struct EditExerciseView: View {
    @EnvironmentObject var vm: GenerateWorkoutViewModel
    var day: Day
    @State var exercise: Exercise

    @State var exercisePicker: Exercise = MockData.mockExercises.randomElement()!
    @State var reps: Double = 1
    @State var sets: Double = 1
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Picker("Exercise Picker", selection: $exercisePicker) {
                ForEach(MockData.mockExercises, id: \.self) { exercise in
                    if exercise.muscleGroup == self.exercise.muscleGroup {
                        Text(exercise.name).tag(exercise)
                    }
                }
            }
            VStack() {
                HStack {
                    Text("Reps")
                    Spacer()
                }
                Slider(
                    value: $reps,
                    in: 1...30
                )
                Text("\(Int(reps)) reps")
            }
            VStack() {
                HStack {
                    Text("Sets")
                    Spacer()
                }
                Slider(
                    value: $sets,
                    in: 1...10
                )
                Text("\(Int(sets)) sets")
            }
            
            Button(action: {
                vm.changeExercise(day: day, exercise: exercise, newExercise: exercisePicker)
                
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Edit")
                    .padding(.vertical, 4)
                    .frame(maxWidth: .infinity)
            })
            .padding(.vertical)
            .buttonStyle(.borderedProminent)
        }
    }
}

//#Preview {
//    EditExerciseView()
//}
