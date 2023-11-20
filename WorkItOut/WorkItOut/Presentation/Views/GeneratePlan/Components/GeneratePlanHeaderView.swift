//
//  GeneratePlanHeaderView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct GeneratePlanHeaderView: View {
    @EnvironmentObject var dm: DataManager
    @EnvironmentObject var vm: GeneratePlanViewModel
    
    var body: some View {
        ZStack {
            if vm.showHeader {
                VStack {
                    Image("AssesmentResultHeaderBackground")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .ignoresSafeArea()
                    Spacer()
                }
            }
            
            VStack(alignment: .leading) {
                if vm.showHeader {
                    VStack(alignment: .leading) {
                        Text("Workout Plan for Beginner - New Beginnings")
                            .font(.largeTitle)
                            .bold()
                        Text("You are in week \(dm.profile!.currentPregnancyWeek) of pregnancy, so we are giving you the \(dm.profile!.trimester.getLocalizedString()) trimester yoga plan!")
                    }
                    .padding(.horizontal)
                        
                }
//                DayPickerView(days: dm.profile!.daysAvailable, selection: dm.profile!.daysAvailable[0])
//                    .environmentObject(vm)
//                    .padding(.top)
            }
        }
    }
}

#Preview {
    GeneratePlanHeaderView()
}
