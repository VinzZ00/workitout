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
                if !vm.workoutPlan.workouts.isEmpty {
                    List(Day.allCases, id: \.self) { day in
                        if vm.workoutWeekday.keys.contains(where: {$0 == day}) {
                            NavigationLink("\(day.rawValue)") {
                                WorkoutDayView(day: day)
                                    .environmentObject(vm)
                            }
                        }
                        else {
                            Text("\(day.rawValue)")
                        }
                        
                    }
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
                vm.refreshWorkoutPlan()
            })
        }
        
        
        
    }
}

#Preview {
    GenerateWorkoutView()
        .preferredColorScheme(.dark)
}
