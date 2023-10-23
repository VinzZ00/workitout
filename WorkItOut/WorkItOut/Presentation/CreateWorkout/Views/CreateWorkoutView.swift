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
                    VStack() {
                        HStack {
                            Text("Height")
                            Spacer()
                        }
                        Slider(
                            value: $vm.height,
                            in: 100...200
                        )
                        Text("\(Int(vm.height)) cm")
                    }
                    VStack {
                        HStack {
                            Text("Weight")
                            Spacer()
                        }
                        Slider(
                            value: $vm.weight,
                            in: 100...200
                        )
                        Text("\(Int(vm.weight)) kg")
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            Text("Available Days")
                            Spacer()
                        }
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
                                    Text(day.rawValue)
                                        .foregroundStyle(vm.checkDay(day: day) ? .purple : .white)
                                }
                                .buttonStyle(.bordered)

                            }
                        }
                        
                    }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            Text("Muscle Group")
                            Spacer()
                        }
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
                                    Text(muscle.rawValue)
                                        .foregroundStyle(vm.checkMuscleGroup(muscleGroup: muscle) ? .purple : .white)
                                }
                                .buttonStyle(.bordered)

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
                
                Button {
                    vm.createWorkout()
                    
//                    vm.objectWillChange.send()
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Submit")
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                }
                .padding(.vertical)
                .buttonStyle(.borderedProminent)
            }
            
            
        }
        .padding()
        
    }
}

#Preview {
    CreateWorkoutView()
        .preferredColorScheme(.dark)
}
