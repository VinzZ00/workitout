//
//  DayAssessment.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 25/10/23.
//

import SwiftUI

struct DayAssessment: View {
    
    var exercises : [Exercise]
    var day : Int
    var bodyPart : String
    var weekday : String
    var timeOfDay : String
    var editCompletion : () -> Void;
    
    var body: some View {
        VStack (){
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Day \(day) - \(bodyPart)")
                    Text("\(weekday), \(timeOfDay)")
                        .foregroundColor(.neutral3)
                }
                Spacer()
                
                Button {
                    editCompletion()
                } label: {
                    Image(systemName: "pencil")
                        .foregroundColor(.black)
                        
                }.padding(.vertical)
                
            }.padding(.horizontal, 17)
            
            ForEach(exercises) { exercise in
                workoutListCard(imageAssetName: exercise.name, workoutName: exercise.name, muscle: (exercise.muscleGroup.map{ return $0.rawValue}), manySet: exercise.workoutSet, manyReps: exercise.repetition)
            }
        }
    }
}

#Preview {
    DayAssessment(exercises: [
        Exercise(name: "PushUP", muscleGroup: [.arm, MuscleGroup.back, .core], equipment: [.dipbar], repetition: 12, workoutSet: 4),
        Exercise(name: "PushUP", muscleGroup: [.arm, MuscleGroup.back, .core], equipment: [.dipbar], repetition: 12, workoutSet: 4),
        Exercise(name: "PushUP", muscleGroup: [.arm, MuscleGroup.back, .core], equipment: [.dipbar], repetition: 12, workoutSet: 4),
    ],day: 1, bodyPart: "Upper Body", weekday: "Monday", timeOfDay: "Noon") {
        print("clicked")
    }
}
