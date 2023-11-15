//
//  DataManager.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation
import CoreData

@MainActor
class DataManager: ObservableObject {
    @Published var pm: PoseFirebaseManager = PoseFirebaseManager()
    @Published var profile: Profile?
    var addProfile: AddProfileUseCase = AddProfileUseCase()
    var fetchProfile : FetchProfileUseCase = FetchProfileUseCase()
    @Published var hasNoProfile : Bool = false
    @Published var savedToCoreData : Bool = false
    
    var handMadeYogaPlan: [Relieve : [YogaPlan]] = [:]
    
    public func loadProfile(moc : NSManagedObjectContext) async throws -> Bool {
        let fetchProfile = FetchProfileUseCase()
        let fetchRes : [Profile]
        
        do {
            fetchRes = try await fetchProfile.call(context: moc)
        } catch {
            return true
        }
        
        if fetchRes.isEmpty{
            return false
        }
        self.profile = fetchRes.first
        savedToCoreData = true
        return true
    }
    
    public func setUpProfile(moc: NSManagedObjectContext, profile: Profile) async {
        self.profile = profile
        
        self.profile!.plan = []
        for trimester in Trimester.allCases {
            self.profile!.plan.append(PoseManager.createYogaPlan(poses: pm.poses, trimester: trimester, days: profile.daysAvailable, duration: profile.preferredDuration, exceptions: profile.exceptions, relieves: []))
        }
        
        self.handMadeYogaPlan = PoseManager.createHandMadeYogaPlan(profile: profile, poses: pm.poses)
    }
}
