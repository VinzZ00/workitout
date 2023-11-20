//
//  HomeView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

enum TabBarEnum: LocalizedStringResource, CaseIterable {
    case today = "Today"
    case plan = "Plan"
    case explore = "Explore"
    
    var icon: String {
        switch self {
        case .today:
            return "rectangle"
        case .plan:
            return "rectangle.grid.1x2"
        case .explore:
            return "rectangle.grid.2x2"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .today:
            HomeTodayView()
                
        case .plan:
            HomePlanView()
        case .explore:
            HomeExploreView()
        }
    }
}

struct HomeView: View {
    @StateObject var vm: HomeViewModel = HomeViewModel()
    @State private var path : NavigationPath = NavigationPath()
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dm : DataManager
    @State var alert : Bool = false
    
    @State var selected: TabBarEnum = .today
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                selected.view
                
                HomeTabView(selected: $selected)
            }
            .ignoresSafeArea(edges: .bottom)
            .background(Color.background)
            .sheet(isPresented: $vm.showProfile, onDismiss: {
                Task{
                    do{
                        try await vm.loadProfile(moc: moc)
                    } catch {
                        self.alert = true
                    }
                }
            }, content: {
                NavigationStack{
                    ProfileView(vm: ProfileViewModel(profile: vm.profile))
                }
            })
            .navigationDestination(for: String.self) { string in
                ExecutionView(vm: ExecutionViewModel(yoga: vm.currentYoga), path: $path)
                    .environmentObject(dm)
                    .navigationBarBackButtonHidden()
            }
        }
        .environmentObject(vm)
        .onAppear{
            Task{
                do {
                    try await vm.loadProfile(moc: moc)
                } catch {
                    self.alert = true
                }
            }
        }
        .sheet(isPresented: $vm.sheetToggle, content: {
            YogaDetailView(yvm: YogaDetailViewModel(oldYoga: vm.yoga ?? Yoga()), sheetToggle: $vm.sheetToggle, path: $path, yogaTitle: vm.yogaTitle)
                .padding(.top)
        })
    }
}

#Preview {
    HomeView()
}
