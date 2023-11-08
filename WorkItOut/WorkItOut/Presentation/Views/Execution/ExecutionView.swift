//
//  ExecutionView.swift
//  WorkItOut 
//
//  Created by Angela Valentine Darmawan on 30/10/23.
//

import SwiftUI
import CoreData
import AVKit

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
    @State var avPlayer = AVPlayer()
    
    var body: some View {
        VStack {
            if !vm.end {
                HStack{
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        ZStack{
                            Circle()
                                .opacity(0.02)
                                .frame(width: 40, height: 40)
                            Image("tabler-icon-x")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                    }
                    Spacer()
                    HStack (spacing: 20){
                        Text("Exercise \(vm.index + 1)/\(vm.poses.count)")
                            .font(.system(size: 14))
                        Button{
                            
                        }label: {
                            ZStack{
                                Circle()
                                    .opacity(0.02)
                                    .frame(width: 40, height: 40)
                                Image("tabler-icon-scan-eye")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                AVPlayerController(player: avPlayer)
                    .frame(width: 358, height: 300)
                    .cornerRadius(12)
                    .onAppear {
                        avPlayer.play()
                    }
                
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
                        ZStack{
                            Circle()
                                .stroke(Color.neutral6)
                                .frame(width: 44, height: 44)
                            Image("tabler-icon-player-skip-back")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .disabled(previousDisabled)
                    
                    Button{
                        if timerVm.isTimerPaused == false{
                            timerVm.pauseTimer()
                            avPlayer.pause()
                        }else {
                            timerVm.continueTimer()
                            avPlayer.play()
                        }
                        
                    }label: {
                        if timerVm.isTimerPaused == false{
                            ZStack{
                                Circle()
                                    .frame(width: 68, height: 68)
                                    .foregroundColor(.primary)
                                Image("tabler-icon-player-pause")
                                    .resizable()
                                    .frame(width: 24, height: 28)
                            }
                        }else {
                            ZStack{
                                Circle()
                                    .frame(width: 68, height: 68)
                                    .foregroundColor(.primary)
                                Image("tabler-icon-player-play")
                                    .resizable()
                                    .frame(width: 22.75, height: 28)
                            }
                        }
                    }
                    .padding(.horizontal, 50)
                    Button{
                        vm.nextPose(skipped: true)
                        if !(vm.index + 1 >= vm.poses.count) {
                            timerVm.resetTimer(time: Double(vm.poses[vm.index+1].seconds))
                        }
                    }label: {
                        ZStack{
                            Circle()
                                .stroke(Color.neutral6)
                                .frame(width: 44, height: 44)
                            Image("tabler-icon-player-skip-forward")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
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
        .onAppear{
//            self.avPlayer = AVPlayer(url: Bundle.main.url(forResource: vm.poses[vm.index].name, withExtension: "MOV")!)
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
