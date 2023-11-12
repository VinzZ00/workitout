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
    
    @EnvironmentObject var dm: DataManager
    @State var alert : Bool = false;
    var body: some View {
        ZStack{
            VStack{
                ScrollView(showsIndicators: false){
                    HStack{
                        Image(systemName: "info.circle.fill")
                        Text("Your yoga plan will be updated when you save the changes of assessment")
                    }
                    .foregroundStyle(Color.neutral3)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 8)
                    .padding(.vertical)
                    .background(.ultraThinMaterial)
                    .borderedCorner()
                    VStack(alignment: .leading){
                        Text("Pregnancy & Health Condition")
                            .foregroundStyle(.gray)
                            .bold()
                            .padding(.top, 14)
                        NavigationLink(value: AssessmentState.chooseWeek) {
                            ProfileCard(assessmentState: .chooseWeek, value: vm.convertToStrings(currentPregnancyWeek: vm.currentPregnancyWeek))
                        }
                        NavigationLink(value: AssessmentState.chooseExceptions) {
                            ProfileCard(assessmentState: .chooseExceptions, value: vm.exceptions.isEmpty ? "None" : vm.convertToStrings(exceptions: vm.exceptions))
                        }
                    }
                    .padding(.bottom, 24)
                    VStack(alignment: .leading){
                        Text("Yoga Plan")
                            .foregroundStyle(.gray)
                            .bold()
                        NavigationLink(value: AssessmentState.chooseDay) {
                            ProfileCard(assessmentState: .chooseDay, value: vm.convertToString(days: vm.daysAvailable))
                        }
                        NavigationLink(value: AssessmentState.chooseDuration) {
                            ProfileCard(assessmentState: .chooseDuration, value: vm.preferredDuration.rawValue)
                        }
                        NavigationLink(value: AssessmentState.chooseTime) {
                            ProfileCard(assessmentState: .chooseTime, value: vm.timeOfDay.rawValue)
                        }
                        NavigationLink(value: AssessmentState.chooseExperience){
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
                                    vm.showAlert = true
                                }
                            }
                        } label: {
                            ZStack{
                                Circle()
                                    .tint(Color.neutral3.opacity(0.1))
                                    .frame(width: 40)
                                Image(systemName: "xmark")
                                    .foregroundStyle(Color.neutral3)
                                    .font(.system(size: 10))
                                    .bold()
                            }
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            Task{
                                dm.pm.addPosetoPoses()
                                vm.setProfile()
                                await dm.setUpProfile(moc: moc, profile: vm.profile)
                                vm.profile = dm.profile!
                                await vm.saveProfile(moc: moc)
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Update")
                                .bold(!vm.equalWithProfile())
                                .foregroundStyle(vm.equalWithProfile() ? Color.neutral3 : Color.primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(vm.equalWithProfile() ? Color.neutral3.opacity(0.1) : Color.primary.opacity(0.1))
                                .cornerRadius(4)
                        }
                        .padding(.top, 12)
                        .disabled(vm.equalWithProfile())
                    }
                }
                .navigationDestination(for: AssessmentState.self, destination: { state in
                    AssessmentWrapperView(stateValue: state)
                        .environmentObject(vm)
                        .presentationDragIndicator(.hidden)
                })
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
                        Text("Discard Changes")
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)
                            .frame(width: 250)
                        Text("Looks like you have changes, Are you sure want to exit?")
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                        Button("Exit"){
                            vm.revertProfile()
                            self.presentationMode.wrappedValue.dismiss()
                        }.buttonStyle(BorderedButton())
                        Button("Cancel"){
                            withAnimation(.easeOut(duration: 0.15)) {
                                vm.showAlert = false
                            }
                        }.buttonStyle(OutlineButton())
                    }
                }
                .padding(.vertical, 20)
                .background()
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("My Assessment")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden()
        .alert(isPresented: self.$alert) {
            Alert(title: Text("Error"), message: Text("Sorry, your Profile Change is not saved, Please recheck your profile"))
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView(vm: ProfileViewModel())
    }
}
