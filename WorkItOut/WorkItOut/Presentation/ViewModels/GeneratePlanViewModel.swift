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
    @Published var showHeader: Bool = true
    @Published var finish: Bool = false

    func addProfileToCoreData(profile: Profile, moc: NSManagedObjectContext) async {
        var addProfile: AddProfileUseCase = AddProfileUseCase()
        await addProfile.call(profile: profile, context: moc)

        var fetchProfile = FetchProfileUseCase()

        let fetchRes = await fetchProfile.call(context: moc)
    }
}
