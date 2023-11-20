//
//  ExecutionView.swift
//  WorkItOut 
//
//  Created by Angela Valentine Darmawan on 30/10/23.
//

import AVKit
import SwiftUI
import CoreData

struct ExecutionView: View {
    @Environment(\.managedObjectContext) var moc : NSManagedObjectContext
    @EnvironmentObject var dm : DataManager
    @StateObject var vm : ExecutionViewModel
    @StateObject var timerVm : TimerViewModel = TimerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var previousDisabled = true
    @State var nextDisabled = false
    @State var progress: CGFloat = 0.0
    @State var showAlert = false
    @Binding var path :  NavigationPath
    
    var body: some View {
        ZStack(alignment: .center){
            VStack {
                if !vm.end {
                    HStack{
                        Button{
                            withAnimation(.easeIn(duration: 0.25)) {
                                showAlert = true
                            }
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
                                .animation(.default, value: vm.index)
                                .contentTransition(.numericText(value: Double(vm.index)))
                            Button{
                                // Vision
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
                    if let _ = UIImage(named: vm.poses[vm.index].name){
                        PoseImageCard(name: vm.poses[vm.index].name, width: 358)
                    }else{
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 358, height: 358)
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
                    if vm.textSwitch == false {
                        Spacer()
                        Text("Get Started")
                            .font(.system(size: 48))
                            .bold()
                        Spacer()
                    }
                    else {
                        Spacer()
                        VStack {
                            Text("\(timerVm.currentTime())")
                                .font(.system(size: 60))
                                .bold()
                                .animation(.default, value: timerVm.timeRemaining)
                                .contentTransition(.numericText(value: timerVm.timeRemaining))
                            ZStack(alignment: .leading) {
                              Rectangle()
                                .frame(width: 240, height: 12)
                                .opacity(0.3)
                                .foregroundColor(.gray)
                              Rectangle()
                                .frame(width: progress * 240, height: 12)
                                .foregroundColor(.primary)
                                .animation(.easeInOut, value: progress)
                            }
                            .cornerRadius(15)
                            .onReceive(timerVm.timer) { _ in
                                if progress < 1.0 {
                                    progress += 1/Double(vm.poses[vm.index].seconds-1)
                                }
                            }
                        }
                        Spacer()
                    }
                    HStack{
                        Button{
                            vm.previousPose()
                            if !(vm.index == 0){
                                timerVm.resetTimer(time: Double(vm.poses[vm.index-1].seconds + 2))
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
                                vm.avPlayer?.pause()
                            }else {
                                timerVm.continueTimer()
                                vm.avPlayer?.play()
                            }
                            
                        }label: {
                            Image(systemName: timerVm.isTimerPaused ? "play.fill" : "pause.fill")
                                .font(.largeTitle)
                                .foregroundStyle(Color.white)
                                .padding()
                                .background(Color.primary)
                                .clipShape(.circle)
                                .animation(.default, value: timerVm.isTimerPaused)
                                .contentTransition(.symbolEffect(.automatic))
//                            if timerVm.isTimerPaused == false{
//                                ZStack{
//                                    Circle()
//                                        .frame(width: 68, height: 68)
//                                        .foregroundColor(.primary)
//                                    Image("tabler-icon-player-pause")
//                                        .resizable()
//                                        .frame(width: 24, height: 28)
//                                }
//                            }else {
//                                ZStack{
//                                    Circle()
//                                        .frame(width: 68, height: 68)
//                                        .foregroundColor(.primary)
//                                    Image("tabler-icon-player-play")
//                                        .resizable()
//                                        .frame(width: 22.75, height: 28)
//                                }
//                            }
                        }
                        .padding(.horizontal, 50)
                        Button{
                            vm.nextPose(skipped: true)
                            if !(vm.index + 1 >= vm.poses.count) {
                                timerVm.resetTimer(time: Double(vm.poses[vm.index+1].seconds + 2))
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
                        vm.textSwitch = false
                        progress = 0.0
                        timerVm.startTimer(time: Double(vm.poses[vm.index].seconds + 2))
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
                    .onChange(of: vm.showTips) { _, valueIsTrue in
                        if !valueIsTrue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                vm.textSwitch.toggle()
                            }
                        }
                    }
                    .onReceive(timerVm.timer) { _ in
                        timerVm.updateCurrentTime()
                        if Int(timerVm.timeRemaining) == vm.poses[vm.index].seconds {
                            vm.textSwitch = true
                        }
                    }
                    
                }
            }
            if vm.showTips {
                TipView(showTips: $vm.showTips, toggle: $vm.checkBox)
            }
            if showAlert {
                ZStack{
                    Color(.accent)
                        .opacity(0.25)
                        .ignoresSafeArea()
                    VStack(spacing: 30){
                        ZStack{
                            Circle()
                                .frame(width: 70)
                                .foregroundStyle(Color.primary.opacity(0.1))
                            Image(systemName: "exclamationmark.triangle")
                                .font(.largeTitle)
                                .foregroundStyle(Color.primary)
                        }
                        VStack(spacing: 10){
                            Text("Are you sure you want to exit this session?")
                                .font(.title2.bold())
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                            Text("This session will not be saved")
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.center)
                                .frame(width: 300)
                            Button("Cancel"){
                                withAnimation(.easeOut(duration: 0.15)) {
                                    showAlert = false
                                }
                            }.buttonStyle(BorderedButton())
                            Button("Exit"){
                                self.presentationMode.wrappedValue.dismiss()
                            }.buttonStyle(OutlineButton())
                        }
                    }
                    .padding(.vertical, 20)
                    .background()
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                }
            }
        }
        
        .onAppear{
            if let valueUserDefault = vm.accessUserDefault() {
                vm.checkBox = valueUserDefault
            }
            if !vm.checkBox {
                vm.showTips = true
            }
            timerVm.startTimer(time: Double(vm.poses[vm.index].seconds + 2))
        }
        .navigationDestination(isPresented: $vm.end) {
            ExecutionCompleteView(path: $path, vm: vm)
                .environmentObject(dm)
        }
    }
}

#Preview {
    ExecutionView(vm: ExecutionViewModel(yoga: Yoga()), path: .constant(NavigationPath()))
}
