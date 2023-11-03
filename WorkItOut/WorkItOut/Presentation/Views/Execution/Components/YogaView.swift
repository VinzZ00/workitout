//
//  YogaView.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 31/10/23.
//

import SwiftUI

struct YogaView: View {
    var exercise: String
    var nextExercise: String
    var time: Double
    var image: String
    var indexExercise: Int
    var allExercise: Int
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
                    Text("Exercise \(indexExercise + 1)/\(allExercise)")
                        .font(.system(size: 14))
                    Button{
                        
                    }label: {
                        Image(systemName: "camera.viewfinder")
                            .font(.title2)
                    }
                }
            }
            .padding(.horizontal, 20)
            
//            Image(image)
//                .resizable()
//                .frame(width: 358, height: 316)
//                .scaledToFit()
//                .cornerRadius(12)
//                .padding(16)
            Rectangle()
                .frame(width: 358, height: 316)
                .cornerRadius(12)
                .padding([.horizontal, .top], 16)
            
            Text("\(exercise)")
                .font(.title)
                .bold()
            
            if indexExercise + 1 == allExercise {
                Text("Next: \(nextExercise)")
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 14)).hidden()
            }else{
                Text("Next: \(nextExercise)")
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
                TimerView(vm: TimerViewModel(), time: time)
                    .padding(40)
            }
            
            Rectangle()
                .frame(width: 355, height: 12)
            
            HStack{
                Button{
                    
                }label: {
                    Image(systemName: "backward.end.circle")
                        .font(.system(size: 44))
                }
                .onAppear(perform: {
                    if indexExercise == 0 {
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
                    
                }label: {
                    Image(systemName: "forward.end.circle")
                        .font(.system(size: 44))
                }
                .onAppear(perform: {
                    if indexExercise + 1 == allExercise {
                        nextDisabled = true
                    }
                })
                .disabled(nextDisabled)
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    YogaView(exercise: "Plank", nextExercise: "Push Up", time: 60, image: "Plank", indexExercise: 4, allExercise: 5)
}
