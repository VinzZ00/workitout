//
//  YogaDetailHeaderView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 20/11/23.
//

import SwiftUI

struct YogaDetailHeaderView: View {
    @EnvironmentObject var yvm: YogaDetailViewModel
    @State var state: YogaPreviewEnum = .relieveChoice
    var yogaTitle: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(state.getTitle(yoga: yvm.newYoga, yogaTitle: yogaTitle))
                .font(.largeTitle)
                .bold()
            state.getDescription(yoga: yvm.oldYoga)
        }
    }
}

#Preview {
    YogaDetailHeaderView()
}
