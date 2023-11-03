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
    @StateObject var vm = ExecutionViewModel()
    @State var textSwitch = false
    @State var previousDisabled = false
    @State var nextDisabled = false
    
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
                Text("Exercise \(vm.index + 1)/\(vm.pose.count)")
                    .font(.system(size: 14))
                Button{
                    
                }label: {
                    Image(systemName: "camera.viewfinder")
                        .font(.title2)
                }
            }
        }
        .padding(.horizontal, 20)
        
//            Image(vm.pose[vm.index].image ?? "")
//                .resizable()
//                .frame(width: 358, height: 316)
//                .scaledToFit()
//                .cornerRadius(12)
//                .padding(16)
        Rectangle()
            .frame(width: 358, height: 316)
            .cornerRadius(12)
            .padding([.horizontal, .top], 16)
        
        Text("\(vm.pose[vm.index].name)")
            .font(.title)
            .bold()
        
        if vm.index + 1 == vm.pose.count {
            Text("Next: \(vm.pose[vm.index+1].name)")
                .foregroundStyle(Color.gray)
                .font(.system(size: 14)).hidden()
        }else{
            Text("Next: \(vm.pose[vm.index+1].name)")
                .foregroundStyle(Color.gray)
                .font(.system(size: 14))
        }
        
        
        if textSwitch == false {
            Text("Get Started")
                .font(.system(size: 48))
                .bold()
                .padding(50)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.textSwitch.toggle()
                    }
                }
        }else {
            TimerView(vm: TimerViewModel(), time: Double(vm.pose[vm.index].seconds))
                .padding(40)
        }
        
        Rectangle()
            .frame(width: 355, height: 12)
        
        HStack{
            Button{
                vm.previousPose()
            }label: {
                Image(systemName: "backward.end.circle")
                    .font(.system(size: 44))
            }
            .onAppear(perform: {
                if vm.index == 0 {
                    previousDisabled = true
                }
            })
            .disabled(previousDisabled)
            
            Button{
                
            }label: {
                Image(systemName: "pause.circle")
                    .font(.system(size: 68))
            }
            .padding(.horizontal, 50)
            
            Button{
                vm.nextPose()
            }label: {
                Image(systemName: "forward.end.circle")
                    .font(.system(size: 44))
            }
            .onAppear(perform: {
                if vm.index + 1 == vm.pose.count {
                    nextDisabled = true
                }
            })
            .disabled(nextDisabled)
        }
        .padding(.top, 40)
    }
    .onChange(of: vm.index) { _, _ in
        vm.call()
        nextDisabled = false
        previousDisabled = false
    }
//            if !(vm.pose.isEmpty) {
//                YogaView(exercise: vm.pose[vm.index].name, nextExercise: vm.pose[vm.index+1].name, time: Double(vm.pose[vm.index].seconds), image: vm.pose[vm.index].image ?? "", indexExercise: vm.index, allExercise: vm.pose.count)
//            }
           
//        .onAppear{
//            vm.call()
////            Task {
////                await setupViewModel()
////            }
//
    }
    
//    func setupViewModel() async {
//        await vm.addProfile(context: moc)
//        vm.call()
//        vm.objectWillChange.send()
//    }
}

#Preview {
    ExecutionView()
}
