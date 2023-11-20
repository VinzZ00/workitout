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
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(Trimester.getTrimesterExceptAll(), id: \.self) { trimester in
                        ScrollView {
                            LazyVStack {
                                VStack(alignment: .center) {
                                    Text(trimester.getTitle())
                                        .font(.title.bold())
                                    Text(trimester.getDesc())
                                }
                                .multilineTextAlignment(.center)
                                .padding()
                                GeneratePlanYogaView(yogaPlan: dm.profile!.getYogasByTrimester(trimester: trimester))
                                    .borderedCorner()
                                    .padding(.horizontal)
                            }
                            .frame(width: UIScreen.main.bounds.width)
                            .borderedCorner()
                        }
                        
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $scrollPosition)
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
