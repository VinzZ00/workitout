//
//  TestExploreView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct ExploreBodyView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Relieve.getFunctionalRelieves(), id: \.self) { relieve in
                        HomeYogaCategoryView(relieve: relieve)
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            ScrollView {
                VStack {
                    ForEach(Relieve.getFunctionalRelieves(), id: \.self) { relieve in
                        VStack {
                            if vm.selectedRelieve == relieve {
                                ForEach(0..<self.vm.getHandmadeYogaPlans(relieve: relieve).count, id: \.self) { i in
                                    HomeOtherPlansView(yogaPlan: self.vm.getHandmadeYogaPlans(relieve: relieve)[i], image: "Handmade\(relieve.getString())\(i+1)")
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 4)
                .animation(.default, value: vm.selectedRelieve)
            }
            
        }
        .padding()
    }
}

#Preview {
    ExploreBodyView()
}
