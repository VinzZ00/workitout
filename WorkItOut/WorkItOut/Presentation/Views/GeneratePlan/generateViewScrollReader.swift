//
//  ScrollListenerViewBuilder.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct GeneratePlanScrollViewBuilder : View {
    @EnvironmentObject var vm : GeneratePlanViewModel
    @EnvironmentObject var dm : DataManager
    @Binding var scrollTarget: Int?
    @Binding var showContent: Bool
    
    init(scrollTarget: Binding<Int?> = .constant(0),showContent: Binding<Bool>) {
        self._showContent = showContent
        self._scrollTarget = scrollTarget
    }
    
    
    
    var body: some View {
        ScrollViewReader( content: { (proxy: ScrollViewProxy) in
            if dm.profile!.plan.isEmpty {
                Text("No Plan yet")
            } else {
                ScrollView {
                    GeometryReader { prox in
                        VStack {
                            
                            VStack(alignment: .leading) {
                                ForEach(dm.profile!.yogas) { yoga in
                                    VStack(alignment: .leading) {
                                        Text(yoga.day.getString())
                                            .font(.title3)
                                            .bold()
                                            .id(yoga.day.getInt())
                                        ForEach(PoseManager.existingCategories(poses: yoga.poses), id: \.self) { category in
                                            HStack {
                                                Text(category.rawValue)
                                                    .font(.subheadline)
                                                    .foregroundStyle(Color.neutral3)
                                                    .bold()
                                                Rectangle()
                                                    .frame(height: 0.5)
                                                    .foregroundStyle(Color.neutral6)
                                            }
                                            
                                            ForEach(PoseManager.getPosesByCategory(poses: yoga.poses, category: category)) { pose in
                                                YogaCardView(name: pose.name)
                                            }
                                        }
                                    }
                                    .padding()
                                    .background(.white)
                                    .padding(.bottom)
                                }
                            }
                            .background(Color.background)
                        }.background(Color.clear.preference(key: ViewOffsetKey.self, value: -prox.frame(in: .named("scroll")).origin.y))
                    }
                }
//                .background(GeometryReader {
//                    Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
//                })
                .onPreferenceChange(ViewOffsetKey.self) {
                    print("offset >> \($0)")
                    scrollTarget = Int($0);
                }
                .onChange(of: scrollTarget) { target in
                    if let target = target {
                        scrollTarget = nil
                        
                        withAnimation {
                            proxy.scrollTo(target, anchor: .center)
                        }
                    }
                }
                .coordinateSpace(name: "scroll")
            }
                
        })
    }
}

private struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value -= nextValue()
    }
}

//#Preview {
//    ScrollListenerViewBuilder()
//}
