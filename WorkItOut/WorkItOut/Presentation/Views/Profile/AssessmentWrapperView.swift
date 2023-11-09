//
//  AssessmentWrapperView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 01/11/23.
//

import SwiftUI

struct AssessmentWrapperView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm : ProfileViewModel
    @State var stateValue : AssessmentState
    var body: some View {
        VStack{
            VStack{
                switch stateValue {
                    case .chooseDay:
                        AssessmentDetailMultipleChoiceView(title: "Which days of the week are you available for exercise? ", explanation: "(Pick Three)", selectedItems: $vm.days, selections: Day.allCases, limit: 3)
                    case .chooseTime:
                        AssessmentDetailView(title: "When do you want to be reminded to do yoga?", selection: $vm.timeClock, selections: TimeOfDay.allCases)
                    case .chooseDuration:
                        AssessmentDetailView(title: "How long does a typical exercise session fit into your schedule?", selection: $vm.durationExercise, selections: Duration.allCases)
                    case .chooseWeek:
                        AssesmentWeekView(week: $vm.currentWeek)
                    case .chooseExperience:
                        AssessmentDetailView(title: "Have you ever done yoga before?", selection: $vm.experience, selections: Difficulty.allCases)
                    case .chooseExceptions:
                        AssessmentDetailMultipleChoiceView(title: "Do you have any health conditions?", selectedItems: $vm.exceptions, selections: Exception.allCases)
                default:
                    EmptyView()
                }
                Spacer()
            }
            .padding(.horizontal, 15)
            Button("Save"){
                vm.saveProfile()
                self.presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(BorderedButton())
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        vm.revertProfile()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                    }
                    .tint(Color.neutral6)
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationStack{
        AssessmentWrapperView(stateValue: .chooseExceptions)
            .environmentObject(ProfileViewModel())
    }
}
