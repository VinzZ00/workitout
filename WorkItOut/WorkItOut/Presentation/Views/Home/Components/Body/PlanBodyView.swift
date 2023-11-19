//
//  TestPlanBodyView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct PlanBodyView: View {
    @EnvironmentObject var dm: DataManager
    @Binding var picker: Trimester
    @State var scrollPosition: Trimester?
    
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
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Trimester.getTrimesterExceptAll(), id: \.self) { trimester in
                                VStack {
                                    VStack(alignment: .center) {
                                        Text("First Trimester - New Beginnings")
                                            .font(.title.bold())
                                        Text("You are in week 4 of pregnancy, so we are giving you the first trimester yoga plan!")
                                    }
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical)
                                    GeneratePlanYogaView(yogaPlan: dm.profile!.getYogasByTrimester(trimester: trimester))
                                        .borderedCorner()
                                        .padding(.horizontal)
                                }
                                .frame(width: UIScreen.main.bounds.width)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $scrollPosition)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .animation(.easeInOut.speed(1), value: scrollPosition)
        .onChange(of: scrollPosition) {
            if let scrollPosition {
                picker = scrollPosition
            }
        }
        .onChange(of: picker) {
            scrollPosition = picker
        }
    }
}

#Preview {
    PlanBodyView(picker: .constant(.first))
}
