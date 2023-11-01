//
//  ExecutionView.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 30/10/23.
//

import SwiftUI
import CoreData

struct ExecutionView: View {
    @Environment(\.managedObjectContext) var moc : NSManagedObjectContext
    @State var vm = ExecutionViewModel()
    
    
    var body: some View {
        VStack {
            HStack{
                Button{
                    
                }label: {
                    Image(systemName: "x.circle.fill")
                        .font(.title2)
                }
                Spacer()
                HStack (spacing: 20){
                    Text("Exercise 1/5")
                        .font(.system(size: 14))
                    Button{
                        
                    }label: {
                        Image(systemName: "camera.viewfinder")
                            .font(.title2)
                    }
                }
            }
            .padding(.horizontal, 20)
            
//            Image(vm.pose[vm.index].image)
//                .resizable()
//                .frame(width: 358, height: 316)
//                .scaledToFit()
//                .cornerRadius(12)
//                .padding(16)
            Rectangle()
                .frame(width: 358, height: 316)
                .cornerRadius(12)
                .padding([.horizontal, .top], 16)
            
            if !vm.profile.isEmpty {
                    Text("\(vm.pose[vm.index].name)")
        //            Text("Testing 1") // MARK: DEBUG
                        .font(.title)
                        .bold()
                    Text("Next: \(vm.pose[vm.index+1].name)")
        //            Text("Testing 2") // MARK: DEBUG
                        .foregroundStyle(Color.gray)
                        .font(.system(size: 14))
        //            Text("Get Started")
        //                .font(.system(size: 48))
        //                .bold()
        //                .padding(50)
        //
                    TimerView(vm: TimerViewModel(), time: Double(vm.pose[vm.index].seconds))
                }
            
            Rectangle()
                .frame(width: 355, height: 12)
            
            HStack{
                Button{
                    
                }label: {
                    Image(systemName: "backward.end.circle")
                        .font(.system(size: 44))
                }
                Button{
                    
                }label: {
                    Image(systemName: "pause.circle")
                        .font(.system(size: 68))
                }
                .padding(.horizontal, 50)
                
                Button{
                    
                }label: {
                    Image(systemName: "forward.end.circle")
                        .font(.system(size: 44))
                }
            }
            .padding(.top, 40)
        }
        .onAppear{
            
            Task {
                await setupViewModel()
            }
            
        }
        .onChange(of: vm.index) { _, _ in
            vm.call()
        }
    }
    
    func setupViewModel() async {
        await vm.addProfile(context: moc)
        vm.call()
        vm.objectWillChange.send()
    }
}

#Preview {
    ExecutionView()
}
