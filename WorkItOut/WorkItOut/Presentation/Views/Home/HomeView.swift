//
//  HomeView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm: HomeViewModel = HomeViewModel()
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dm : DataManager
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image("AssesmentResultHeaderBackground")
                        .ignoresSafeArea()
                    VStack {
                        HStack {
                            HomeButtonView(icon: "person")
                            Spacer()
                            HomeWeekIndicatorView()
                                .environmentObject(vm)
                            Spacer()
                            HomeButtonView(icon: "clock.arrow.circlepath")
                        }
                        .padding(.bottom)
                        HStack {
                            ForEach(Day.allCases, id: \.self) { day in
                                DayButtonView(selectedDay: $vm.day, days: vm.days, day: day)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                }
                .background(.white)
                
                ScrollView {
                    HomeCurrentYogaView()
                        .environmentObject(vm)
                    
                    VStack(alignment: .leading) {
                        Text("Exercise that might help you")
                            .font(.title2)
                            .bold()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(Relieve.allCases, id: \.self) { relieve in
                                    HomeYogaCategoryView(relieve: relieve)
                                }
                            }
                        }
                        ForEach(dm.handMadeYogaPlan[vm.selectedRelieve] ?? vm.yogaPlans, id: \.id) { yogaPlan in
                            HomeOtherPlansView(yogaPlan: yogaPlan)
                        }
                    }
                    .padding()
                }
            }
            
            .background(Color.background)
            .sheet(isPresented: $vm.sheetToggle, content: {
                YogaDetailView(yoga: vm.currentYoga)
            })
        }
        .environmentObject(vm)
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    HomeView()
//}
