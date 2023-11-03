//
//  HomeView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm: HomeViewModel = HomeViewModel()
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dm : DataManager
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "person")
                            .padding(12)
                            .background(.neutral3.opacity(0.02))
                            .clipShape(.circle)
                    })
                    .buttonStyle(.plain)
                    
                    
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "chevron.left")
                    })
                    VStack {
                        if dm.profile.name.isEmpty {
                            Text("No Name")
                        }
                        else {
                            Text("\(dm.profile.name)")
                        }
                        
                        Text("Week 12 - August")
                            .font(.title3)
                            .bold()
                        Text("(Trimester II)")
                    }
                    Button(action: {}, label: {
                        Image(systemName: "chevron.right")
                    })
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .padding(12)
                            .background(.neutral3.opacity(0.02))
                            .clipShape(.circle)
                    })
                    .buttonStyle(.plain)
                }
                .padding(.vertical)
                
                HStack {
                    ForEach(vm.days, id: \.self) { _ in
                        DayButtonView()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            
            
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Today, 26 October")
                            .font(.title3)
                            .bold()
                        Text("Balancing and Grounding")
                            .font(.largeTitle)
                            .bold()
                        Text("5 Exercise (60 Min)")
                            .font(.body)
                        ButtonComponent(title: "Start Exercise") {
                            vm.sheetToggle.toggle()
                        }
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 12))
                }
                .padding()
                .frame(width: 360, height: 480)
                .background(.purple)
                .clipShape(.rect(cornerRadius: 12))
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("Exercise that might help you")
                        .font(.title)
                        .bold()
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(vm.relieves, id: \.self) { relieve in
                                Button(action: {
                                    vm.selectedRelieve = relieve
                                }, label: {
                                    Text(relieve.getString())
                                        .foregroundStyle(relieve == vm.selectedRelieve ? .purple : .black)
                                        .padding(12)
                                        .clipShape(.rect(cornerRadius: 12))
                                        .background(RoundedRectangle(cornerRadius: 12)
                                            .fill(relieve == vm.selectedRelieve ? .main.opacity(0.25) : .white)
                                            .stroke(relieve == vm.selectedRelieve ? .orangePrimary : .grayBorder, lineWidth: 1)
                                        )
                                })
                            }
                        }
                    }
                    ForEach(0...4, id: \.self) { _ in
                        HStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.purple)
                                .clipShape(.rect(cornerRadius: 12))
                            VStack(alignment: .leading) {
                                Text("Exercise Plan Name (One time exercise only)")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                                Text("6 Exercise (60 Min)")
                            }
                            Spacer()
                        }
                        .padding(8)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 12))

                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea(.keyboard)
        .background(Color("Background"))
        .sheet(isPresented: $vm.sheetToggle, content: {
            YogaDetailView()
        })
//        .task({
//            await dm.loadProfile(moc: moc)
//        })
//        .onAppear {
//            Task {
//                await dm.loadProfile(moc: moc)
//            }
//        }
    }
}

#Preview {
    HomeView()
}
