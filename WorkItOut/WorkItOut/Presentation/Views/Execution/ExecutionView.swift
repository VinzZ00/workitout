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
    @ObservedObject var timerVm = TimerViewModel()
    @State var textSwitch = false
    @State var previousDisabled = true
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
        VStack{
            Text("\(vm.pose[vm.index].name)")
                .font(.title)
                .bold()
            
            if !(vm.index + 1 == vm.pose.count) {
                Text("Next: \(vm.pose[vm.index+1].name)")
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 14))
            }
        }
        .padding()
        
//        Spacer()
        
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
            VStack {
                Text("\(timerVm.currentTime())")
                    .font(.system(size: 60))
                    .bold()
                    .onReceive(timerVm.timer){ _ in
                        timerVm.updateCurrentTime()
                    }
            }
            .onAppear(perform: {
                timerVm.startTimer(time: Double(vm.pose[vm.index].seconds))
            })
                .padding(42)
        }
        
        Rectangle()
            .frame(width: 355, height: 12)
        
        HStack{
            Button{
                vm.previousPose()
                if !(vm.index == 0){
                    timerVm.resetTimer(time: Double(vm.pose[vm.index-1].seconds))
                }
                
            }label: {
                Image(systemName: "backward.end.circle")
                    .font(.system(size: 44))
            }
            .disabled(previousDisabled)
            
            Button{
                if timerVm.isTimerPaused == false{
                    timerVm.pauseTimer()
                }else {
                    timerVm.continueTimer()
                }
                
            }label: {
                if timerVm.isTimerPaused == false{
                    Image(systemName: "pause.circle")
                        .font(.system(size: 68))
                }else {
                    Image(systemName: "play.circle")
                        .font(.system(size: 68))
                }
                
            }
            .padding(.horizontal, 50)
            
            Button{
                vm.nextPose()
                if !(vm.index + 1 == vm.pose.count) {
                    timerVm.resetTimer(time: Double(vm.pose[vm.index+1].seconds))
                }
            }label: {
                Image(systemName: "forward.end.circle")
                    .font(.system(size: 44))
            }
            .disabled(nextDisabled)
        }
        .padding(.top, 40)
    }
    .onChange(of: vm.index) { _, _ in
        if vm.index + 1 == vm.pose.count {
            nextDisabled = true
        }else {
            nextDisabled = false
        }
        
        if vm.index == 0 {
            previousDisabled = true
        }else{
            previousDisabled = false
        }
        
        timerVm.isTimerPaused = false
        textSwitch = false
    }
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
