//
//  ScrollListenerViewBuilder.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct CustomScrollListenerViewBuilder<Content: View>: View {
    let content: Content
    
    @Binding var scrollTarget: Int?
    @Binding var showContent: Bool

    init(scrollTarget: Binding<Int?> = .constant(0),showContent: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._showContent = showContent
        self._scrollTarget = scrollTarget
        self.content = content()
    }
    
    var body: some View {
        ScrollViewReader( content: { (proxy: ScrollViewProxy) in
            ScrollView {
                content
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) {
                        print("offset >> \($0)")
                        if $0 > 10 {
                            showContent = false
                        }
                        else {
                            showContent = true
                        }
                    }
            }
            .onChange(of: scrollTarget) { _, target in
                if let target = target {
                    scrollTarget = nil
                    
                    withAnimation {
                        proxy.scrollTo(target, anchor: .center)
                    }
                }
            }
            .coordinateSpace(name: "scroll")
        })
    }
}

private struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

//#Preview {
//    ScrollListenerViewBuilder()
//}
