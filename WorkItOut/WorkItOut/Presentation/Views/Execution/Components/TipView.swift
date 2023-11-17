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
        ZStack {
            Color(.accent)
                .opacity(0.25)
                .ignoresSafeArea()
            VStack(spacing: 20){
                Image("PregnantTips")
                    .resizable()
                    .frame(width: 180, height: 180)
                VStack(alignment: .leading){
                    Text("Tips for Pregnancy Exercise")
                        .font(.title2.bold())
                    Text("""
                         • Listen to your body and don't push yourself too hard.
                         • Modify poses as needed to accommodate your growing belly.
                         • Drink plenty of water before, during, and after your practice.
                         • Wear comfortable clothing that allows you to move freely.
                         """)
                    .font(.footnote)
                    .padding(.horizontal, 4)
                }
                CheckBox("Don't show again in the future", toggle: $toggle)
                
                Button("Got It"){
                    withAnimation(.easeOut(duration: 0.25)) {
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: "skipPregnancyTips")
                        showTips = false
                    }
                }
                .buttonStyle(BorderedButton())
            }
            .padding()
            .background()
            .cornerRadius(8)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    TipView(showTips: .constant(true), toggle: .constant(false))
}
