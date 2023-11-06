//
//  GeneratePlanViewModel.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import CoreData
import Foundation

@MainActor
class GeneratePlanViewModel: ObservableObject {
    @Published var scrollTarget: Int?
    
    func checkCategory(poses: [Pose], category: Category) -> Bool {
        if (poses.first(where: {$0.category == category}) != nil) {
            return true
        }
        return false
    }
    func addProfileToCoreData(profile: Profile, moc: NSManagedObjectContext) async {
        var addProfile: AddProfileUseCase = AddProfileUseCase()
        await addProfile.call(profile: profile, context: moc)

        var fetchProfile = FetchProfileUseCase()

        let fetchRes = await fetchProfile.call(context: moc)
    }
}
