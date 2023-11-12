//
//  TestView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 12/11/23.
//

import SwiftUI

struct TestView: View {
    @State var show: Bool = false
    
    var body: some View {
        VStack {
            if show {
                Image("YogaStatusExist")
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            }
            else {
                Image("YogaStatusNone")
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            }
            Button(action: {
                show.toggle()
                
            }, label: {
                Text("Toggle")
            })
            .buttonStyle(.borderedProminent)
        }
        .animation(.default, value: show)
        
    }
}

#Preview {
    TestView()
}
