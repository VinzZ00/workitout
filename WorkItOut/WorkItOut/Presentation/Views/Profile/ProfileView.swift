//
//  ProfileView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    Text("Pregnancy & Health Condition")
                        .foregroundStyle(.gray)
                        .bold()
                        .padding(.top, 14)
                    NavigationLink(value: AssessmentState.chooseWeek) {
                        ProfileCard(assessmentState: .chooseWeek, value: viewModel.convertToStrings(currentPregnancyWeek: viewModel.profile.currentPregnancyWeek))
                    }
                    NavigationLink(value: AssessmentState.chooseExceptions) {
                        ProfileCard(assessmentState: .chooseExceptions, value: viewModel.relieve.isEmpty ? "None" : viewModel.convertToStrings(exceptions: viewModel.exceptions))
                    }
                }
                .padding(.bottom, 24)
                VStack(alignment: .leading){
                    Text("Yoga Plan")
                        .foregroundStyle(.gray)
                        .bold()
                    NavigationLink(value: AssessmentState.chooseDay) {
                        ProfileCard(assessmentState: .chooseDay, value: viewModel.convertToString(days: viewModel.profile.daysAvailable))
                    }
                    NavigationLink(value: AssessmentState.chooseDuration) {
                        ProfileCard(assessmentState: .chooseDuration, value: viewModel.profile.preferredDuration.rawValue)
                    }
                    NavigationLink(value: AssessmentState.chooseTime) {
                        ProfileCard(assessmentState: .chooseTime, value: viewModel.profile.timeOfDay.rawValue)
                    }
                    NavigationLink(value: AssessmentState.chooseExperience) {
                        ProfileCard(assessmentState: .chooseExperience, value: viewModel.profile.fitnessLevel.rawValue)
                    }
                }
                .padding(.bottom, 24)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack{
                            Circle()
                                .tint(.grayBorder.opacity(0.15))
                                .frame(width: 40)
                            Image(systemName: "arrow.left")
                                .font(.system(size: 10))
                                .bold()
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .navigationTitle("Profile")
            .navigationDestination(for: AssessmentState.self, destination: { state in
                AssessmentWrapperView(stateValue: state)
                    .environmentObject(viewModel)
            })
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView()
    }
}
