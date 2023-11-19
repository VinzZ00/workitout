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
    @EnvironmentObject var dm: DataManager

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                switch avm.state {
                    case .chooseWeek:
                        AssesmentWeekView(week: $avm.currentWeek)
                    case .chooseExceptions:
                        AssessmentDetailMultipleChoiceView(title: avm.state.getLocalizedString().title, selectedItems: $avm.exceptions, selections: Exception.allCases)
                    case .chooseDay:
                        AssessmentDetailMultipleChoiceView(title: avm.state.getLocalizedString().title, explanation: "(Pick Three)", selectedItems: $avm.days, selections: Day.allCases, limit: 3)
                    case .chooseDuration:
                    AssessmentDetailView(title: avm.state.getLocalizedString().title, selection: $avm.durationExercise, selections: Duration.allCases)
                    case .chooseExperience:
                        AssessmentDetailView(title: avm.state.getLocalizedString().title, selection: $avm.experience, selections: Difficulty.allCases)
                    case .chooseTime:
                        AssessmentDetailView(title: avm.state.getLocalizedString().title, selection: $avm.timeClock, selections: TimeOfDay.allCases)
                    case .complete:
                        CompleteView(counter: avm.timeRemaining)
                }
                Spacer()
                if avm.state != .complete {
                    ButtonComponent(title: "Next") {
                        avm.nextState()
                    }
                    .disabled(avm.checkDaysIsEmpty() ? true : false)
                }
            }
            .padding(.horizontal, 15)
            .animation(.default, value: avm.state)
            .onReceive(avm.timer, perform: { _ in
                if avm.checkTimer() {
                    dm.pm.addPosetoPoses()
                    Task {
                        await dm.setUpProfile(moc: moc, profile: avm.createProfile())
                        avm.finishCreateYogaPlan = true
                    }
                    
                    
                    // Save User Default current week
                    if avm.userdefaultUseCase.saveToUserDefault(currentWeek: avm.currentWeek) {
                        print("userDefault saved successfully")
                    } else {
                        print("user default didn't saved successfully from assessment view")
                    }
                }
            })
            .navigationDestination(isPresented: $avm.finishCreateYogaPlan) {
//                GeneratePlanView()
//                    .environmentObject(avm)
                GenerateViewPlanV2()
                    .environmentObject(avm)
            }
            .toolbar {
                if avm.state != .complete {
                    ToolbarItem(placement: .topBarLeading) {
                        IconButtonComponent(icon: "chevron.left") {
                            if avm.state == .chooseWeek {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            else {
                                avm.previousState()
                            }
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        StateIndicator(state: $avm.state)
                    }
                }
                
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
        
}

#Preview {
    AssessmentView()
}
