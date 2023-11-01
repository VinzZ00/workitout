//
//  AssessmentView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import SwiftUI

struct AssessmentView: View {
    @StateObject var avm : AssessmentViewModel = AssessmentViewModel()
    
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        NavigationStack{
            VStack{
                switch avm.state {
                    case .chooseDay:
                        AssessmentDetailMultipleChoiceView(title: "Which days of the week are you available for exercise? ", explanation: "(Pick Three)", selectedItems: $avm.days, selections: Day.allCases, limit: 3)
                    case .chooseTime:
                        AssessmentDetailView(title: "On the days you're available, what times work best for you?", selection: $avm.timeClock, selections: TimeOfDay.allCases)
                    case .chooseDuration:
                        AssessmentDetailView(title: "How long does a typical exercise session fit into your schedule?", selection: $avm.durationExercise, selections: Duration.allCases)
                    case .chooseMonth:
                        AssessmentDetailView(title: "How long do you plan to follow your exercise routine?", selection: $avm.timeSpan, selections: Months.allCases)
                    case .chooseExperience:
                        AssessmentDetailView(title: "Have you ever done yoga before?", selection: $avm.experience, selections: Difficulty.allCases)
                    case .chooseTrimester:
                        AssessmentDetailView(title: "What trimester are you in?", selection: $avm.trimester, selections: Trimester.allCases)
                    case .chooseRelieve:
                        AssessmentDetailMultipleChoiceView(title: "Is there a problem you are experiencing lately?", selectedItems: $avm.relieve, selections: Relieve.allCases)
                    case .complete:
                        CompleteView()
                }
            }
            .navigationDestination(isPresented: $avm.finishCreateYogaPlan) {
                GeneratePlanView()
            }
            .padding(.horizontal, 15)
            Spacer()
            .onChange(of: avm.days.isEmpty || avm.relieve.isEmpty, { oldValue, newValue in
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
            }
            else if avm.state == .complete {
                Button("Next"){
                    withAnimation {
                        Task {
                            var dm: DataManager = DataManager()
                            
                            await dm.setUpProfile(
                                moc: moc,
                                name: "User Name",
                                currentWeek: 10,
                                currentRelieveNeeded: avm.relieve,
                                fitnessLevel: avm.experience,
                                daysAvailable: avm.days,
                                timeOfDay: avm.timeClock,
                                preferredDuration: avm.durationExercise,
                                plan: [],
                                histories: []
                            )
                        }
                        
                        avm.finishCreateYogaPlan.toggle()
                    }
                }
                .buttonStyle(BorderedButton())
//                NavigationLink {
//                    GeneratePlanView()
//                } label: {
//                    Text("Next")
//                }
//                .buttonStyle(BorderedDisabledButton())

            }
            else {
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
