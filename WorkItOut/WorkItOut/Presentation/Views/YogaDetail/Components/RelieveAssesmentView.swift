//
//  RelieveAssesmentView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct RelieveAssesmentView: View {
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Relieve.allCases, id: \.self) { relieve in
                    Button(action: {
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
