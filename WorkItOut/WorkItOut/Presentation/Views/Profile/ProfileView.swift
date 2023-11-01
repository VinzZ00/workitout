//
//  ProfileView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import SwiftUI

struct ProfileView: View {
    var viewModel = ProfileViewModel()
    var body: some View {
        ScrollView{
            VStack{
                VStack(alignment: .leading){
                    Text("Pregnancy & Health Condition")
                        .foregroundStyle(.gray)
                        .bold()
                        .padding(.top, 14)
                    ProfileCard(assessmentState: .chooseMonth, value: String(viewModel.profile.currentPregnancyWeek))
                    ProfileCard(assessmentState: .chooseRelieve, value: "None")
                }
                .padding(.bottom, 24)
                VStack(alignment: .leading){
                    Text("Yoga Plan")
                        .foregroundStyle(.gray)
                        .bold()
                    ProfileCard(assessmentState: .chooseDay, value: viewModel.convertToString(days: viewModel.profile.daysAvailable))
                    ProfileCard(assessmentState: .chooseDuration, value: viewModel.profile.preferredDuration.rawValue)
                    ProfileCard(assessmentState: .chooseTime, value: viewModel.profile.timeOfDay.rawValue)
                    ProfileCard(assessmentState: .chooseExperience, value: viewModel.profile.fitnessLevel.rawValue)
                }
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView()
    }
    
}
