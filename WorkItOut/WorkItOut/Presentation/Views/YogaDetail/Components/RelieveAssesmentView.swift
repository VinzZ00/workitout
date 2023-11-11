//
//  RelieveAssesmentView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct RelieveAssesmentView: View {
    @State var selectedRelieves: [Relieve] = []
    @State var selections : [Relieve] = [.back, .hip, .neck, .leg, .pelvic]
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(selections, id: \.self) { relieve in
                    Button(action: {
                        if selectedRelieves.contains(relieve){
                            guard let selectedIndex = selectedRelieves.firstIndex(of: relieve) else {
                                return
                            }
                            selectedRelieves.remove(at: selectedIndex)
                        }
                        else{
                            selectedRelieves.append(relieve)
                        }
                        print(relieve)
                    }, label: {
                        VStack {
                            Image(relieve.getAsset())
                                .resizable()
                                .frame(width: 50, height: 98)
                            Text("\(relieve.getString())")
                                .bold()
                        }
                        .frame(width: 150, height: 170)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedRelieves.contains(relieve) ? Color.primary.opacity(0.25) : .clear)
                                .stroke(Color.neutral6)
                        }
                    })
                }
            }
            
            .padding(.vertical)
        }
    }
}

#Preview {
    RelieveAssesmentView()
}
