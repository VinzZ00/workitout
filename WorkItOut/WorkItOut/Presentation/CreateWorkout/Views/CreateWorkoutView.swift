//
//  CreateWorkoutView.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import SwiftUI

struct CreateWorkoutView: View {
    @StateObject var vm: CreateWorkoutViewModel = CreateWorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ForEach(MockData.mockWorkout.exercises, id: \.name) { exercise in
                Text(exercise.name)
            }
            ScrollView {
                Group {
                    Text("Placeholder Form")
                        .font(.title)
                        .fontWeight(.semibold)
                    SliderComponent(title: "Height", value: $vm.height, measurementUnit: "cm", minRange: 100, maxRange: 200)
                    SliderComponent(title: "Weight", value: $vm.weight, measurementUnit: "kg", minRange: 100, maxRange: 200)
                    ScrollView(.horizontal) {
                        VStack(alignment: .leading) {
                            Text("Available Days")
                            HStack {
                                ForEach(Day.allCases, id: \.self) { day in
                                    Button {
                                        if vm.checkDay(day: day) {
                                            vm.removeDay(day: day)
                                        }
                                        else {
                                            vm.addDay(day: day)
                                        }
                                    } label: {
                                        Text("\(day.rawValue)")
                                            .foregroundStyle(vm.checkDay(day: day) ? .purple : .white)
                                    }
                                    .buttonStyle(.bordered)

                                }
                            }
                        }
                        
                        
                    }
                    
                    ScrollView(.horizontal) {
                        VStack(alignment: .leading) {
                            Text("Muscle Group")
                            HStack {
                                ForEach(MuscleGroup.allCases, id: \.self) { muscle in
                                    Button {
                                        if vm.checkMuscleGroup(muscleGroup: muscle) {
                                            vm.removeMuscleGroup(muscleGroup: muscle)
                                        }
                                        else {
                                            vm.addMuscleGroup(muscleGroup: muscle)
                                        }
                                    } label: {
                                        Text("\(muscle.rawValue)")
                                            .foregroundStyle(vm.checkMuscleGroup(muscleGroup: muscle) ? .purple : .white)
                                    }
                                    .buttonStyle(.bordered)

                                }
                            }
                        }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Other")
                            Spacer()
                        }
                        HStack {
                            Button {
                                vm.hasEquipment.toggle()
                            } label: {
                                Text("Equipment")
                                    .bold(vm.hasEquipment)
                            }
                            .buttonStyle(.borderedProminent)
                            Button {
                                vm.needReminder.toggle()
                            } label: {
                                Text("Reminder")
                                    .bold(vm.needReminder)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
                .padding(4)
                
                ButtonComponent(title: "Submit") {
                    vm.createWorkout()
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            
            
        }
        .padding()
        
    }
}

#Preview {
    CreateWorkoutView()
        .preferredColorScheme(.dark)
}
