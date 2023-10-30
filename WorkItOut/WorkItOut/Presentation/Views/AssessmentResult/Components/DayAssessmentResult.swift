//
//  DayAssessment.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 25/10/23.
//

import SwiftUI

struct DayAssessment: View {
    
    var exercises : [Pose]
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
                workoutListCard(imageAssetName: "Asset Name", workoutName: "Name", muscle: ["Something"], manySet: 0, manyReps: 0)
            }
        }
    }
}

#Preview {
    DayAssessment(exercises: [
        Pose(name: "Example Name", description: "Example Description", seconds: DateInterval(), state: .completed, category: .armBalance, recommendedTrimester: .first, bodyPartTrained: [.arms, .back], relieve: [.backpain, .breathing], difficulty: .beginner),
        Pose(name: "Example Name", description: "Example Description", seconds: DateInterval(), state: .completed, category: .armBalance, recommendedTrimester: .first, bodyPartTrained: [.arms, .back], relieve: [.backpain, .breathing], difficulty: .beginner),
        Pose(name: "Example Name", description: "Example Description", seconds: DateInterval(), state: .completed, category: .armBalance, recommendedTrimester: .first, bodyPartTrained: [.arms, .back], relieve: [.backpain, .breathing], difficulty: .beginner),
    ],day: 1, bodyPart: "Upper Body", weekday: "Monday", timeOfDay: "Noon") {
        print("clicked")
    }
}
