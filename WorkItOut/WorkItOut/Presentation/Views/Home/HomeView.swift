//
//  HomeView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct HomeView: View {
    @State var sheetToggle: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {}, label: {
                    Label("Week 12", systemImage: "chevron.down")
                })
                Spacer()
                Image(systemName: "gearshape")
                Image(systemName: "chart.bar")
            }
            HStack {
                ForEach(0...7, id: \.self) { _ in
                    VStack {
                        Text("Sun")
                        Text("4")
                    }
                }
            }
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Today, 26 October")
                    Text("Balancing and Grounding")
                    Text("5 Exercise (60 Min)")
                    ButtonComponent(title: "Start Exercise") {
                        sheetToggle.toggle()
                    }
                }
                .padding()
                .frame(width: 360, height: 480)
                .background(.purple)
                .clipShape(.rect(cornerRadius: 12))
                
                VStack {
                    Text("Exercise that might help you")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0...7, id: \.self) { _ in
                                Button(action: {}, label: {
                                    Text("Popular")
                                })
                            }
                        }
                    }
                    ForEach(0...4, id: \.self) { _ in
                        HStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .background(.purple)
                                .clipShape(.rect(cornerRadius: 12))
                            VStack(alignment: .leading) {
                                Text("Exercise Plan Name (One time exercise only)")
                                Spacer()
                                Text("6 Exercise (60 Min)")
                            }
                        }
                    }
                }
            }
            
        }
        .sheet(isPresented: $sheetToggle, content: {
            VStack(alignment: .leading) {
                Image(systemName: "xmark")
                Text("Balancing and Grounding")
                Text("5 Exercise (50 Min)")
                ForEach(0...5, id: \.self) { _ in
                    YogaCardView()
                }
                ButtonComponent(title: "Start Now") {
                    //
                }
            }
        })
    }
}

#Preview {
    HomeView()
}
