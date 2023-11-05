//
//  BorderedCorner.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI

struct BorderedCorner: ViewModifier {
    func body(content: Content) -> some View {
            content
                .clipShape(.rect(cornerRadius: 12))
        }
}

extension View {
    func borderedCorner() -> some View {
        modifier(BorderedCorner())
    }
}
