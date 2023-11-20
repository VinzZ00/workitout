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
    
//    @Published var pose: Pose = Pose(id: UUID())
//    @Published var showSheet: Bool = false

    func addProfileToCoreData(profile: Profile, moc: NSManagedObjectContext) async throws {
        let addProfile: AddProfileUseCase = AddProfileUseCase()
        try await addProfile.call(profile: profile, context: moc)

        let fetchProfile = FetchProfileUseCase()

        do {
            _ = try await fetchProfile.call(context: moc)
        } catch {
            print("error")
        }
    }
}
