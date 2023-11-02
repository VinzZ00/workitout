//
//  HistoryView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 02/11/23.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm : HistoryViewModel = HistoryViewModel()
    var body: some View {
        LazyVStack{
            ScrollView{
                if !vm.historiesWithDate.isEmpty{
                    ForEach(vm.historiesWithDate.keys.sorted(), id: \.self){ date in
                        HistorySection(date: vm.historiesWithDate[date]!.first?.executionDate ?? Date.distantFuture, histories: vm.historiesWithDate[date]!)
                    }
                }
                else{
                    Text("No History to show")
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button { self.presentationMode.wrappedValue.dismiss() }
                label: {
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
        }
        .navigationTitle("History")
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HistoryView()
}
