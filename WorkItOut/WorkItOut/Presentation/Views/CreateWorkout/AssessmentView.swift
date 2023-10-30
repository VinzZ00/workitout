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
                    CompleteView()
                }
            }
            .padding(.horizontal, 15)
            Spacer()
            .onChange(of: avm.day.isEmpty || avm.muscleGroup.isEmpty, { oldValue, newValue in
                avm.buttonDisable = newValue
            })
            .toolbar{
                if avm.state != .chooseDay {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                avm.previousState()
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    StateIndicator(state: $avm.state)
                }
            }
            if avm.buttonDisable {
                Button("Next"){
                    
                }
                .buttonStyle(BorderedDisabledButton())
            }else {
                Button("Next"){
                    withAnimation {
                        avm.nextState()
                    }
                    
                }
                .buttonStyle(BorderedButton())
            }
            
        }
        
        
    }
        
}

#Preview {
    AssessmentView()
}
