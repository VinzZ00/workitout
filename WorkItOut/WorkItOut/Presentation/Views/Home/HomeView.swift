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
            return "doc.text.image"
        case .plan:
            return "tray.full"
        case .explore:
            return "rectangle.grid.1x2"
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
                    .onAppear{
                        Task{
                            do {
                                try await vm.loadProfile(moc: moc)
                            } catch {
                                self.alert = true
                            }
                        }
                    }
            }
            .background(Color.neutral6)
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
                ExecutionView(vm: ExecutionViewModel(yoga: vm.getYogaByDay(day: vm.day)!), path: $path)
                    .environmentObject(dm)
                    .navigationBarBackButtonHidden()
            }
        }
        .environmentObject(vm)
        
        .sheet(isPresented: $vm.sheetToggle, content: {
            YogaDetailView(yvm: YogaDetailViewModel(oldYoga: vm.getYogaByDay(day: vm.day) ?? Yoga()), sheetToggle: $vm.sheetToggle, path: $path, yogaTitle: vm.yogaTitle)
                .padding(.top)
        })
    }
}

#Preview {
    HomeView()
}
