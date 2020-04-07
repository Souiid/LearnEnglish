//
//  FirestoreProtocol.swift
//  Learn English
//
//  Created by Idriss Souissi on 31/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import Foundation
import Firebase

protocol FirestoreProtocol {
    func downloadUsersDataNameAge(callback: @escaping (String, Int)-> Void)
    func downLoadItemsLevel(callback: @escaping ([String: Int])->Void)
    func updateData(fields: [AnyHashable : Any])
}
