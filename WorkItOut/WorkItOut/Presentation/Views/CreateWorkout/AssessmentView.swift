//
//  AssessmentView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import SwiftUI

struct AssessmentView: View {
    @StateObject var avm : AssessmentViewModel = AssessmentViewModel()
    var body: some View {
        NavigationStack{
            Spacer()
            VStack{
                switch avm.state {
                case .chooseDay:
                    AssessmentDetailMultipleChoiceView(title: "Which days of the week are you available for exercise? ", selectedItems: $avm.day, selections: Day.allCases.map({$0.rawValue}))
                        
                case .chooseTime:
                    AssessmentDetailView(title: "On the days you're available, what times work best for you?", selection: $avm.timeClock, selections: TimeClock.allCases.map({$0.rawValue}))
                case .chooseDuration:
                    AssessmentDetailView(title: "How long does a typical exercise session fit into your schedule?", selection: $avm.durationExercise, selections: Duration.allCases.map({$0.rawValue}))
                case .chooseMonth:
                    AssessmentDetailView(title: "How long do you plan to follow your exercise routine?", selection: $avm.timeSpan, selections: Months.allCases.map({$0.rawValue}))
                case .chooseMuscleGroup:
                    AssessmentDetailMultipleChoiceView(title: "Which muscle groups are you interested in training?", selectedItems: $avm.muscleGroup, selections: MuscleGroup.allCases.map({$0.rawValue}))
                case .complete:
                    Text("Complete liau")
                }
            }
            .padding(.horizontal, 10)
            Spacer()
            Button("Next"){
                avm.nextState()
            }
            .toolbar{
                if avm.state != .chooseDay{
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {avm.previousState()}, label: {
                            Image(systemName: "chevron.left")
                        })
                    }
                }
                
            }
        }
        
        
    }
        
}

#Preview {
    AssessmentView()
}
