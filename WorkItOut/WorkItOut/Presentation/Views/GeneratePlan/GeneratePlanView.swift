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
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            //
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                                .bold()
                        })
                        .padding(.bottom)
                        Spacer()
                    }
                    Text("Workout Plan for Beginner")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .bold()
                }
                .padding(.top, 72)
                .padding()
                .background(
                    Image(.assesmentResultHeader)
                        .resizable()
                        .frame(maxWidth: .infinity)
                )
                
                VStack(alignment: .leading) {
                    ForEach(0...3, id: \.self) { _ in
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Day 1 - Upper Body")
                                        .font(.title3)
                                        .bold()
                                    Text("Mon, Morning")
                                        .foregroundStyle(.neutral3)
                                        .font(.body)
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
                        .padding()
                        .background(.white)
                    }
                }
                .background(.neutral6)
                
            }
            .ignoresSafeArea()
            
            VStack {
                NavigationLinkComponent(destination: AnyView(HomeView()))
            }
            .padding(.horizontal)
            .ignoresSafeArea()
        }
        
        
    }
}

#Preview {
    GeneratePlanView()
}
