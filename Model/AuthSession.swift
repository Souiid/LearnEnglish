//
//  AuthSession.swift
//  Learn English
//
//  Created by Idriss Souissi on 01/02/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import Foundation
import Firebase

class AuthSession: AuthProtocol {
    
    //MARK: - Propreties
    
    ///The current ID of a users in Firestore
    var currentUID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    //MARK: - Propreties
    
    ///Connect a user with email and password
    func signIn(email: String, password: String, callback: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            let db = Firestore.firestore()
            
            
            if error != nil {
                callback(false)
            }else {
                guard let userID = self.currentUID else {return}
                let docRef = db.collection("users").document(userID)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        callback(true)
                    }else{
                        callback(false)
                    }
                }
            }
        }
    }
    
    ///Create a user in Firestore with email, password, age, name and level of themes
    func logIn(email: String, password: String, age: Int, name: String, itemsLevel: NSDictionary, callback: @escaping (Bool, String)->Void) {
       
        if age <= 0 || age > 120 || name.count < 2 || name.count > 10 {
            callback(false, "")
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            let db = Firestore.firestore()
            if error != nil  {
                callback(false, "")
            }else {
                guard let userID = authResult?.user.uid else {return}
                let docRef = db.collection("users").document(userID)
                docRef.setData(["age": age, "name": name, "itemsLevel": itemsLevel])
                callback(true, "Inscription réussie")
            }
        }
    }
    
    ///Disconnect a user
    func signOutUser(callback: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            callback(true)
        } catch {
            callback(false)
        }
    }
    
    ///Check if a user is connected 
   func isUserConnected(callback: @escaping (Bool) -> Void) {
        _ = Auth.auth().addStateDidChangeListener { _, user in
            guard (user != nil) else {
                callback(false)
                  return
            }
              callback(true)
          }
      }
   }
