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
    @StateObject var vm : ExecutionViewModel
    @StateObject var timerVm : TimerViewModel = TimerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var textSwitch = false
    @State var previousDisabled = true
    @State var nextDisabled = false
    @State var progress: CGFloat = 0.0
    @Binding var path : NavigationPath
    
    var body: some View {
        VStack {
            if !vm.end {
                HStack{
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title2)
                    }
                    Spacer()
                    HStack (spacing: 20){
                        Text("Exercise \(vm.index + 1)/\(vm.poses.count)")
                            .font(.system(size: 14))
                        Button{
                            
                        }label: {
                            Image(systemName: "camera.viewfinder")
                                .font(.title2)
                        }
                    }
                }
                .padding(.horizontal, 20)
                Rectangle()
                    .frame(width: 358, height: 316)
                    .cornerRadius(12)
                    .padding([.horizontal, .top], 16)
                VStack{                    
                    Text("\(vm.poses[vm.index].name)")
                            .font(.title)
                            .bold()
                        
                    if !(vm.index + 1 == vm.poses.count) {
                        Text("Next: \(vm.poses[vm.index+1].name)")
                            .foregroundStyle(Color.gray)
                            .font(.system(size: 14))
                    }
                }
                .padding()
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
                        ZStack(alignment: .leading) {
                          Rectangle()
                            .frame(width: 300, height: 20)
                            .opacity(0.3)
                            .foregroundColor(.gray)

                          Rectangle()
                            .frame(width: progress * 300, height: 20)
                            .foregroundColor(.primary)
                            .animation(.easeInOut, value: progress)
                        }
                        .cornerRadius(15)
                        .onReceive(timerVm.timer) { _ in
                          if progress < 1.0 {
                              progress += 0.01/Double(vm.poses[vm.index].seconds-1)
                          }
                        }
                    }
                    .onAppear(perform: {
                        timerVm.startTimer(time: Double(vm.poses[vm.index].seconds))
                    })
                    .padding(14)
                }
                
                HStack{
                    Button{
                        vm.previousPose()
                        if !(vm.index == 0){
                            timerVm.resetTimer(time: Double(vm.poses[vm.index-1].seconds))
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
                            Image(systemName: "pause.circle.fill")
                                .font(.system(size: 68))
                                .foregroundColor(.primary)
                        }else {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 68))
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal, 50)
                    
                    
                    Button{
                        vm.nextPose(skipped: true)
                        if !(vm.index + 1 >= vm.poses.count) {
                            timerVm.resetTimer(time: Double(vm.poses[vm.index+1].seconds))
                        }
                    }label: {
                        Image(systemName: "forward.end.circle")
                            .font(.system(size: 44))
                    }
                    .disabled(nextDisabled)
                    
                }
                .padding(.top, 40)
                .onChange(of: vm.index) { _, _ in
                    if vm.index == vm.poses.count {
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
                    progress = 0.0
                }
                .onChange(of: timerVm.timesUp) { _, valueIsTrue in
                    if valueIsTrue {
                        vm.nextPose(skipped: false)
                        timerVm.timesUp = false
                    }
                }
                .onChange(of: vm.end) { _, valueIsTrue in
                    if valueIsTrue {
                        path.append(1)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $vm.end) {
            ExecutionCompleteView(path: $path, vm: vm)
        }
//        .navigationDestination(for: Int.self) { string in
//            ExecutionCompleteView(path: $path, vm: vm)
//        }
    }
}

#Preview {
    ExecutionView(vm: ExecutionViewModel(yoga: Yoga()), path: .constant(NavigationPath()))
}
