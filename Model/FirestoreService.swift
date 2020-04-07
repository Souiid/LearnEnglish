//
//  FirestoreService.swift
//  Learn English
//
//  Created by Idriss Souissi on 31/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import Foundation
import Firebase

class FirestoreService {
    
    //MARK: - Propreties
    
    var firestore: FirestoreProtocol
    
    init(firestore: FirestoreProtocol = FirestoreSession()) {
        self.firestore = firestore
    }
    
    //MARK: - Propreties
    
    ///Update name and age of a user in Firestore
    func updateUsersData(name: String, age: Int)-> Bool{
        
        if (age <= 0 || age > 120 || name.count < 2 || name.count > 10) {return false}
        if age > 0 {
            firestore.updateData(fields: ["age": age])
        }
        if  name.count >= 2 {
            firestore.updateData(fields: ["name": name])
        }
        return true
    }
    
    ///Update level of theme in Firestore
    func uploadItemsLevel(field: String = "itemsLevel", dictionary: [String: Int]) {
        firestore.updateData(fields: [field: dictionary])
    }
    
    ///Download level of theme from Firestore
    func downloadItemsLevel(callback: @escaping ([String: Int])->Void) {
        firestore.downLoadItemsLevel(callback: callback)
    }
    
    ///Download name and age from Firestore
    func downloadUsersData(callback: @escaping (String, Int)-> Void) {
        firestore.downloadUsersDataNameAge(callback: callback)
    }
}


