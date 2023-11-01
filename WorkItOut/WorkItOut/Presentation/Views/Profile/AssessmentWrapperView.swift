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
                        AssessmentDetailView(title: "On the days you're available, what times work best for you?", selection: $vm.timeClock, selections: TimeOfDay.allCases)
                    case .chooseDuration:
                        AssessmentDetailView(title: "How long does a typical exercise session fit into your schedule?", selection: $vm.durationExercise, selections: Duration.allCases)
                    case .chooseMonth:
                        AssessmentDetailView(title: "How long do you plan to follow your exercise routine?", selection: $vm.timeSpan, selections: Months.allCases)
                    case .chooseExperience:
                        AssessmentDetailView(title: "Have you ever done yoga before?", selection: $vm.experience, selections: Difficulty.allCases)
                    case .chooseTrimester:
                        AssessmentDetailView(title: "What trimester are you in?", selection: $vm.trimester, selections: Trimester.allCases)
                    case .chooseRelieve:
                        AssessmentDetailMultipleChoiceView(title: "Is there a problem you are experiencing lately?", selectedItems: $vm.relieve, selections: Relieve.allCases)
                    case .complete:
                        CompleteView()
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
                    .tint(.grayBorder)
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationStack{
        AssessmentWrapperView(stateValue: .chooseDay)
            .environmentObject(ProfileViewModel())
    }
}
