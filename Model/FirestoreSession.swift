//
//  FirestoreSession.swift
//  Learn English
//
//  Created by Idriss Souissi on 31/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import Foundation
import Firebase

class FirestoreSession: FirestoreProtocol {
    
    ///Download name and age of a user from Firestore
    func downloadUsersDataNameAge(callback: @escaping (String, Int) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userID)
              
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {return}
            guard let description = document.data() else {return}
            guard let name = description["name"] as? String else {return}
            guard let age = description["age"] as? Int else {return}
            callback(name, age)
        }
    }
    
    ///Download level of items of a user from Firestore
    func downLoadItemsLevel(callback: @escaping ([String : Int]) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userID)
              
        docRef.getDocument { (document, error) in
                                          
            if let document = document, document.exists {
                guard let description = document.data() else {return}
                guard let itemsLevel = description["itemsLevel"] as? [String: Int] else {return}
                callback(itemsLevel)
            }else{
                callback([:])
            }
        }
    }

    ///Update data in Firestore
    func updateData(fields: [AnyHashable : Any]) {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userID)
        docRef.updateData(fields)
    }
}
