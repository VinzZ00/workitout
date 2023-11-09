//
//  ProfileView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @StateObject var vm : ProfileViewModel
    @State var selection = 0
    
    @EnvironmentObject var dm: DataManager
    @State var alert : Bool = false;
    var body: some View {
        ZStack{
            VStack{
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        Text("Pregnancy & Health Condition")
                            .foregroundStyle(.gray)
                            .bold()
                            .padding(.top, 14)
                        Button {
                            vm.showSheetwithState(state: .chooseWeek)
                        } label: {
                            ProfileCard(assessmentState: .chooseWeek, value: vm.convertToStrings(currentPregnancyWeek: vm.currentPregnancyWeek))
                        }

                        Button{
                            vm.showSheetwithState(state: .chooseExceptions)
                        } label: {
                            ProfileCard(assessmentState: .chooseExceptions, value: vm.exceptions.isEmpty ? "None" : vm.convertToStrings(exceptions: vm.exceptions))
                        }
                    }
                    .padding(.bottom, 24)
                    VStack(alignment: .leading){
                        Text("Yoga Plan")
                            .foregroundStyle(.gray)
                            .bold()
                        Button{
                            vm.showSheetwithState(state: .chooseDay)
                        } label: {
                            ProfileCard(assessmentState: .chooseDay, value: vm.convertToString(days: vm.daysAvailable))
                        }
                        Button{
                            vm.showSheetwithState(state: .chooseDuration)
                        } label: {
                            ProfileCard(assessmentState: .chooseDuration, value: vm.preferredDuration.rawValue)
                        }
                        Button{
                            vm.showSheetwithState(state: .chooseTime)
                        } label: {
                            ProfileCard(assessmentState: .chooseTime, value: vm.timeOfDay.rawValue)
                        }
                        Button{
                            vm.showSheetwithState(state: .chooseExperience)
                        } label: {
                            ProfileCard(assessmentState: .chooseExperience, value: vm.fitnessLevel.rawValue)
                        }
                    }
                    .padding(.bottom, 24)
                }
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            if vm.equalWithProfile() {
                                self.presentationMode.wrappedValue.dismiss()
                            }else{
                                withAnimation(.easeInOut(duration: 0.15)) {
                                    selection = 1
                                    vm.showAlert = true
                                }
                            }
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
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.15)) {
                                selection = 2
                                vm.showAlert.toggle()
                            }
                        } label: {
                            Text("Save")
                                .foregroundStyle(vm.equalWithProfile() ? .grayBorder : Color(.orangePrimary))
                        }
                        .padding(.top, 10)
                        .disabled(vm.equalWithProfile())
                    }
                }
                .sheet(isPresented: $vm.showSheet, onDismiss: {
                    vm.objectWillChange.send()
                }, content: {
                    AssessmentWrapperView(stateValue: vm.currentState)
                        .environmentObject(vm)
                        .presentationDragIndicator(.hidden)
                        .padding(.top, 24)
                })
                
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarBackButtonHidden()
            }
            
            if vm.showAlert {
                Color(.accent)
                    .opacity(0.25)
                    .ignoresSafeArea()
                
                VStack(spacing: 30){
                    ZStack{
                        Circle()
                            .frame(width: 70)
                            .foregroundStyle(.main.opacity(0.1))
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.main)
                    }
                    VStack(spacing: 10){
                        Text(selection == 1 ? "Exit and Discard Changes" : "Save Profile Changes & Update Yoga Plan")
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)
                            .frame(width: 250)
                        Text(selection == 1 ? "Looks like you have changes, Are you sure you want to exit?" : "Your current and next yoga plan will be updated with your new data.")
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                        Button("Save"){
                            Task{
                                dm.pm.addPosetoPoses()
                                vm.setProfile()
                                await dm.setUpProfile(moc: moc, profile: vm.profile)
                                vm.profile = dm.profile!
                                await vm.saveProfile(moc: moc)
                                self.presentationMode.wrappedValue.dismiss()
                        Button("Discard Changes"){
                            vm.revertProfile()
                            self.presentationMode.wrappedValue.dismiss()
                        }.buttonStyle(OutlineButton())
                    }
                }
                .padding(.vertical, 20)
                .background()
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden()
        }.alert(isPresented: self.$alert) {
            Alert(title: Text("Error"), message: Text("Sorry, your Profile Change is not saved, Please recheck your profile"))
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView(vm: ProfileViewModel())
    }
}
