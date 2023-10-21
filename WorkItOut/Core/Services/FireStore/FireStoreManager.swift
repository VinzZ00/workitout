//
//  FireStoreManager.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation
import FirebaseFirestore

struct FireStoreManager {
    
    static let shared = FireStoreManager();
    
    let db = Firestore.firestore()
    
    
    func getCollection(collectionName : String, completion : @escaping () -> Void) {
        
        var documents : [QueryDocumentSnapshot]?
        
        db.collection(collectionName).getDocuments() { (querySnapshot, err) in
            completion()
        }
    }
    
}
