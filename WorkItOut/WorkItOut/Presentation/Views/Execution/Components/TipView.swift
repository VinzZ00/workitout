//
//  TipView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 10/11/23.
//

import SwiftUI

struct TipView: View {
    @Binding var showTips : Bool
    @Binding var toggle : Bool
    var body: some View {
        ZStack{
            Color(.accent)
                .opacity(0.25)
                .ignoresSafeArea()
            VStack(spacing: 20){
                Image("PregnantTips")
                VStack(alignment: .leading){
                    Text("Tips for Pregnancy Exercise")
                        .font(.title3.bold())
                    Text("""
                         • Listen to your body and don't push yourself too hard.
                         • Modify poses as needed to accommodate your growing belly.
                         • Drink plenty of water before, during, and after your practice.
                         • Wear comfortable clothing that allows you to move freely.
                         """)
                }
                CheckBox("Don't show again in the future", toggle: $toggle)
                Button("Got It"){
                    withAnimation(.easeOut(duration: 0.25)) {
                        showTips = false
                    }
                }.buttonStyle(BorderedButton())
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background()
            .cornerRadius(8)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    TipView(showTips: .constant(true), toggle: .constant(false))
}
