//
//  TestDragGesture.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct TestDragGesture: View {
    @State var viewState = CGSize.zero

    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.blue)
            .frame(width: 300, height: 400)
            .offset(x: viewState.width, y: viewState.height)
            .gesture(
                DragGesture().onChanged { value in
                    viewState = value.translation
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        viewState = .zero
                    }
                }
            )
    }
//    @State private var isDragging = false
//
//    var drag: some Gesture {
//        DragGesture()
//            .onChanged { _ in self.isDragging = true }
//            .onEnded { _ in self.isDragging = false }
//    }
//
//
//    var body: some View {
//        Circle()
//            .fill(self.isDragging ? Color.red : Color.blue)
//            .frame(width: 100, height: 100, alignment: .center)
//            .gesture(drag)
//    }
}

#Preview {
    TestDragGesture()
}
