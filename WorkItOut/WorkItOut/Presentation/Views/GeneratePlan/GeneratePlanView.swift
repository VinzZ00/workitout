//
//  GeneratePlanView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct GeneratePlanView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        //
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("Save")
                    })
                }
                Text("Workout Plan for Beginner")
                    .font(.largeTitle)
                    .bold()
            }
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0...3, id: \.self) { _ in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Day 1 - Upper Body")
                                Text("Mon, Morning")
                            }
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "pencil")
                            })
                        }
                        ForEach(0...4, id: \.self) { _ in
                            YogaCardView()
                        }
                    }
                    
                }
            }
            VStack {
                ButtonComponent(title: "Next") {
                    //
                }
            }
        }
        
    }
}

#Preview {
    GeneratePlanView()
}
