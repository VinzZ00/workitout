//
//  YogaCardViewModel.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 20/11/23.
//

import Foundation

class YogaCardViewModel: ObservableObject {
    @Published var showSheet: Bool = false
    @Published var currentPose: Pose = Pose(id: UUID())
    
    func toggleSheet(pose: Pose) {
        self.currentPose = pose
        showSheet.toggle()
    }
}
