//
//  GenerateWorkoutView.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import SwiftUI

struct GenerateWorkoutView: View {
    @StateObject var vm: GenerateWorkoutViewModel = GenerateWorkoutViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if !vm.workout.exercises.isEmpty {
                    List(Day.allCases, id: \.self) { day in
                        NavigationLink(day.rawValue, value: day)
                            .foregroundStyle(
                                vm.workout.exercises.contains(where: {$0.day == day}) ? .purple : .white
                            )
                    }
                    .navigationDestination(for: Day.self, destination: WorkoutDayView.init)
                    .navigationTitle("Workout Plan")
                }
                else {
                    VStack {
                        Image(systemName: "figure.strengthtraining.traditional")
                            .font(.largeTitle)
                        Text("No Workout Yet")
                            .font(.title3)
                            .bold()
                        Text("Fill form to generate your workout")
                        
                        NavigationLink {
                            CreateWorkoutView(vm: CreateWorkoutViewModel())
                        } label: {
                            Text("Create Workout")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .onAppear(perform: {
                vm.refreshWorkout()
            })
        }
        
        
        
    }
}

#Preview {
    GenerateWorkoutView()
        .preferredColorScheme(.dark)
}
