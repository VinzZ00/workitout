//
//  YogaView.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 31/10/23.
//

import SwiftUI

struct YogaView: View {
    @State var exercise: String
    @State var nextExercise: String
    @State var time: Double
    @State var image: String
//    @State private var textSwitch = false
    
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
            Text("Next: \(nextExercise)")
                .foregroundStyle(Color.gray)
                .font(.system(size: 14))
//            Text("Get Started")
//                .font(.system(size: 48))
//                .bold()
//                .padding(50)
//                .onAppear {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//                        self.textSwitch.toggle()
//                    }
//                }
//            if textSwitch == true {
                TimerView(vm: TimerViewModel(), time: time)
//            }
            
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
    }
}

#Preview {
    YogaView(exercise: "Plank", nextExercise: "Push Up", time: 60, image: "Plank")
}
