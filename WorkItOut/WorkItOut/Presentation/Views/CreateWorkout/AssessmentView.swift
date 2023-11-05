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
    @State var timeRemaining = 2
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch avm.state {
                    case .chooseWeek:
                        AssesmentWeekView(week: $avm.currentWeek)
                    case .chooseExceptions:
                        AssessmentDetailMultipleChoiceView(title: "Do you have any health conditions?", selectedItems: $avm.exceptions, selections: Exception.allCases)
                    case .chooseDay:
                        AssessmentDetailMultipleChoiceView(title: "Which days of the week are you available for exercise? ", explanation: "(Pick Three)", selectedItems: $avm.days, selections: Day.allCases, limit: 3)
                    case .chooseDuration:
                        AssessmentDetailView(title: "How long does a typical exercise session fit into your schedule?", selection: $avm.durationExercise, selections: Duration.allCases)
                    case .chooseExperience:
                        AssessmentDetailView(title: "Have you ever done yoga before?", selection: $avm.experience, selections: Difficulty.allCases)
                    case .chooseTime:
                        AssessmentDetailView(title: "On the days you're available, what times work best for you?", selection: $avm.timeClock, selections: TimeOfDay.allCases)
                    case .complete:
                        CompleteView()
                }
                Spacer()
                
                if avm.buttonDisable {
                    Button("Next"){
                        
                    }
                    .buttonStyle(BorderedDisabledButton())
                }
                else if avm.state == .complete {
                    Button("Next"){
                        withAnimation {
                            dm.pm.addPosetoPoses()
//                            print("something")
                            Task {
                                await dm.setUpProfile(
                                    moc: moc,
                                    name: "User Name",
                                    currentWeek: avm.currentWeek,
                                    fitnessLevel: avm.experience,
                                    daysAvailable: avm.days,
                                    timeOfDay: avm.timeClock,
                                    preferredDuration: avm.durationExercise,
                                    exceptions: avm.exceptions
                                )
                            }
                            
                        }
                    }
                    .buttonStyle(BorderedButton())

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
            // MARK: listen ketika sudah ada pose baru ketriger.
            .onChange(of: dm.pm.poses) { val in
                if !dm.pm.poses.isEmpty {
                    avm.finishCreateYogaPlan = true
                }
            }
            .onReceive(timer, perform: { _ in
//                if timeRemaining > 0 {
//                    timeRemaining -= 1
//                }
//                else if dm.profile.plan.isEmpty {
//                    Task {
//                        await dm.setUpProfile(
//                            moc: moc,
//                            name: "User Name",
//                            currentWeek: avm.currentWeek,
//                            fitnessLevel: avm.experience,
//                            daysAvailable: avm.days,
//                            timeOfDay: avm.timeClock,
//                            preferredDuration: avm.durationExercise,
//                            exceptions: avm.exceptions
//                        )
//                    }
//                }
            })
            .padding(.horizontal, 15)
            .navigationDestination(isPresented: $avm.finishCreateYogaPlan) {
                GeneratePlanView()
                // TODO: dikomen setelah deployment
//                    .navigationBarBackButtonHidden(true)
            }
//            .onChange(of: avm.days.isEmpty || avm.relieve.isEmpty, { oldValue, newValue in
//                avm.buttonDisable = newValue
//            })
            .toolbar {
                if avm.state.rawValue != 0 {
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
        }
        
        
    }
        
}

#Preview {
    AssessmentView()
}
