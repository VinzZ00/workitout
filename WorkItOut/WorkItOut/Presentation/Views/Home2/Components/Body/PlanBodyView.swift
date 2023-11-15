//
//  TestPlanBodyView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct PlanBodyView: View {
    @EnvironmentObject var dm: DataManager
    @State var picker: Trimester = .first
    
    var body: some View {
        VStack {
            Picker("Trimester Picker", selection: $picker) {
                ForEach(Trimester.allCases, id: \.self) { trimester in
                    if trimester != .all {
                        Text(trimester.getRomanString()).tag(trimester)
                    }
                }
            }
            .pickerStyle(.segmented)
            .colorMultiply(Color.white)
            
            ScrollView {
                VStack(alignment: .center) {
                    Text("First Trimester - New Beginnings")
                        .font(.largeTitle.bold())
                    Text("You are in week 4 of pregnancy, so we are giving you the first trimester yoga plan!")
                }
                .padding(.vertical)
                GeneratePlanYogaView(yogaPlan: dm.profile!.getYogasByTrimester(trimester: picker))
                    .borderedCorner()
            }
            
        }
        .padding()
    }
}

#Preview {
    PlanBodyView()
}
