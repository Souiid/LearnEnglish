//
//  AuthProtocol.swift
//  Learn English
//
//  Created by Idriss Souissi on 01/02/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import Foundation
import Firebase

protocol AuthProtocol {
   var currentUID: String? { get }
   func signIn(email: String, password: String, callback: @escaping (Bool) -> Void)
   func logIn(email: String, password: String, age: Int, name: String, itemsLevel: NSDictionary, callback: @escaping (Bool, String)->Void)
   func signOutUser(callback: @escaping (Bool) -> Void)
    func isUserConnected(callback: @escaping (Bool) -> Void)

}
