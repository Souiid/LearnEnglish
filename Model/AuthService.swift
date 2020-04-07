//
//  AuthService.swift
//  Learn English
//
//  Created by Idriss Souissi on 01/02/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    //MARK: - Propreties
    
    var auth: AuthProtocol
    
    ///ID of user
    var currentUID: String? {return auth.currentUID}
    
    init(auth: AuthProtocol = AuthSession()) {
        self.auth = auth
    }
    
    //MARK: - Propreties
    
    ///Connect a user with email and password
    func signIn(email: String, password: String, callback: @escaping (Bool) -> Void) {
        auth.signIn(email: email, password: password, callback: callback)
    }
    
    ///Create a user with email, password, age, name and level of theme
    func logIn(email: String, password: String, age: Int, name: String, itemsLevel: NSDictionary, callback: @escaping (Bool, String)->Void) {
        auth.logIn(email: email, password: password, age: age, name: name, itemsLevel: itemsLevel, callback: callback)
    }
    
    ///Disconnect a user
   func signOut(callback: @escaping (Bool) -> Void) {
        auth.signOutUser(callback: callback)
    }
    
    ///Check if a user is connected
    func isUserConnected(callback: @escaping (Bool) -> Void) {
        auth.isUserConnected(callback: callback)
    }
    
    
    
}
