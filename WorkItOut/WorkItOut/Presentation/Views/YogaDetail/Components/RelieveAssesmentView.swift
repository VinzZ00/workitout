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
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 98, height: 98)
                                .foregroundStyle(Color.primary.opacity(0.5))
                            Text("\(relieve.getString())")
                                .bold()
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 24)
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
