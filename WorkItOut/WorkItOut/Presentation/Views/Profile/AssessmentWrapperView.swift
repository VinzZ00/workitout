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
        VStack(alignment: .leading){
            VStack{
                switch stateValue {
                    case .chooseDay:
                        AssessmentDetailMultipleChoiceView(title: "Which days of the week are you available for exercise? ", explanation: "(Pick Three)", selectedItems: $vm.daysAvailable, selections: Day.allCases, limit: 3)
                    case .chooseTime:
                        AssessmentDetailView(title: "When do you want to be reminded to do yoga?", selection: $vm.timeOfDay, selections: TimeOfDay.allCases)
                    case .chooseDuration:
                        AssessmentDetailView(title: "How long does a typical exercise session fit into your schedule?", selection: $vm.preferredDuration, selections: Duration.allCases)
                    case .chooseWeek:
                        AssesmentWeekView(week: $vm.currentPregnancyWeek)
                    case .chooseExperience:
                        AssessmentDetailView(title: "Have you ever done yoga before?", selection: $vm.fitnessLevel, selections: Difficulty.allCases)
                    case .chooseExceptions:
                        AssessmentDetailMultipleChoiceView(title: "Do you have any health conditions?", selectedItems: $vm.exceptions, selections: Exception.allCases)
                default:
                    EmptyView()
                }
                Spacer()
            }
            .padding(.horizontal, 15)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "multiply")
                    }
                    .tint(Color.neutral6)
                }
            }
            .padding(.horizontal, 15)
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
