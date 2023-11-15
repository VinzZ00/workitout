//
//  RelieveAssesmentView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct RelieveAssesmentView: View {
    @EnvironmentObject var yvm: YogaDetailViewModel
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(yvm.selections, id: \.self) { relieve in
                    Button(action: {
                        if yvm.selectedRelieves.contains(relieve){
                            guard let selectedIndex = yvm.selectedRelieves.firstIndex(of: relieve) else {
                                return
                            }
                            yvm.selectedRelieves.remove(at: selectedIndex)
                        }
                        else{
                            yvm.selectedRelieves.append(relieve)
                        }
                    }, label: {
                        VStack {
                            Image(relieve.getAsset())
                                .resizable()
                                .frame(width: 50, height: 112)
                            Text("\(relieve.getString())")
                                .bold()
                        }
                        .frame(width: 150, height: 160)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(yvm.selectedRelieves.contains(relieve) ? Color.primary.opacity(0.25) : .clear)
                                .stroke(yvm.selectedRelieves.contains(relieve) ? Color.primary : Color.neutral6.opacity(0.5))
                        }
                    })
                }
            }
            .padding(.vertical)
        }
    }
}

//#Preview {
//    RelieveAssesmentView()
//}
