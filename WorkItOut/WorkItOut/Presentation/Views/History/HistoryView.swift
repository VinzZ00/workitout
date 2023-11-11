//
//  HistoryView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 02/11/23.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm : HistoryViewModel
    @State var showSheet = false
    var body: some View {
        ZStack(alignment: .top){
            Image("historyBackground")
                .ignoresSafeArea()
            if !vm.historiesWithDate.isEmpty {
                ScrollView{
                    LazyVStack(spacing: 20) {
                        ForEach(vm.historiesWithDate.keys.sorted(by: {$0 > $1}), id: \.self){ date in
                            HistorySection(date: vm.historiesWithDate[date]!.first?.executionDate ?? Date.distantFuture, histories: vm.historiesWithDate[date]!, showSheet: $showSheet, currentHistory: $vm.currentHistory)
                        }
                    }
                }
                .padding(.vertical, 20)
            }else{
                VStack{
                    Spacer()
                    ZStack{
                        Circle()
                            .frame(width: 76)
                            .foregroundStyle(Color.background)
                        Image(systemName: "folder.badge.questionmark")
                            .font(.system(size: 32))
                            .foregroundStyle(Color.main)
                    }
                    
                    VStack(spacing: 4){
                        Text("No Yoga History")
                            .font(.title3)
                            .foregroundStyle(Color.neutral4)
                            .bold()
                        Text("Your yoga session will be recorded here")
                            .foregroundStyle(Color.neutral6)
                    }
                    Spacer()
                }
                .padding(.bottom, 60)
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button { self.presentationMode.wrappedValue.dismiss() }
            label: {
                ZStack{
                    Circle()
                        .tint(Color.neutral6.opacity(0.15))
                        .frame(width: 40)
                    Image(systemName: "arrow.left")
                        .font(.system(size: 10))
                        .bold()
                }
            }
            }
        }
        .sheet(isPresented: $showSheet){
            if let history = vm.currentHistory{
                NavigationStack{
                    HistorySheet(history: history, showSheet: $showSheet)
                }
            }
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack{
        HistoryView(vm: HistoryViewModel(histories: [
            History(id: UUID(), yogaDone: Yoga(id: UUID(), name: "Yoga", poses: [Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed), Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed)], day: .monday, estimationDuration: 30, yogaState: .completed, image: ""), executionDate: Date.now, duration: 30, rating: 5),
            History(id: UUID(), yogaDone: Yoga(id: UUID(), name: "Yoga", poses: [Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed), Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed)], day: .monday, estimationDuration: 30, yogaState: .completed, image: ""), executionDate: Calendar.current.date(byAdding: .day, value: 2, to: Date.now)!, duration: 30, rating: 5),
            History(id: UUID(), yogaDone: Yoga(id: UUID(), name: "Yoga", poses: [Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed), Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed)], day: .monday, estimationDuration: 30, yogaState: .completed, image: ""), executionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, duration: 30, rating: 5)
        ]))
    }
}
