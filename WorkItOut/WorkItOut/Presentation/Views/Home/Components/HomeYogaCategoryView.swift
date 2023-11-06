//
//  HomeYogaCategoryView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI

struct HomeYogaCategoryView: View {
    @EnvironmentObject var vm: HomeViewModel
    var relieve: Relieve
    
    var body: some View {
        Button(action: {
            vm.selectedRelieve = relieve
        }, label: {
            Text(relieve.getString())
                .foregroundStyle(relieve == vm.selectedRelieve ? .purple : .black)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(relieve == vm.selectedRelieve ? .main.opacity(0.25) : .white)
                        .stroke(relieve == vm.selectedRelieve ? Color.primary : .clear, lineWidth: 1)
                )
        })
    }
}

#Preview {
    HomeYogaCategoryView(relieve: .back)
}
