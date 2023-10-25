//
//  workoutListCard.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 25/10/23.
//

import SwiftUI



struct workoutListCard: View {
    
    var imageAssetName : String
    var workoutName : String
    var muscle : String
    var manySet : Int
    var manyReps : Int
    
    init(imageAssetName: String, workoutName: String, muscle: [String], manySet: Int, manyReps: Int) {
        self.imageAssetName = imageAssetName
        self.workoutName = workoutName
        self.muscle = muscle.joined(separator: ", ");
        self.manySet = manySet
        self.manyReps = manyReps
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(imageAssetName)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .scaledToFill()
                    .cornerRadius(6)
                    .padding(.vertical, 12)
                    .padding(.leading, 12)
                VStack(alignment: .leading) {
                    Text("\(workoutName)")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("\(muscle)")
                        .foregroundColor(.neutral3)
                        .font(.body)
                        
                        
                }
                .padding(.vertical, 11)
                .padding(.leading, 12)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(manySet) Set")
                        .foregroundColor(.neutral3)
                    Text("\(manyReps) Reps")
                        .foregroundColor(.neutral3)
                }
                .padding(.trailing, 12)
                .padding(.vertical, 12)
            }
            .frame(width: 358, height: 88)
            .padding(.all, 12)
            .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.neutral6, lineWidth: 2)
            .padding(.horizontal, 12)
            )
        }
    }
}

#Preview {
    workoutListCard(imageAssetName: "PushUP", workoutName: "PushUp", muscle: ["Chess, Hand, Shoulder"], manySet: 12, manyReps: 4)
}
