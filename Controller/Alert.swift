//
//  Alert.swift
//  Learn English
//
//  Created by Idriss Souissi on 29/02/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    //Show an alert
    func showAlert(title: String, message: String, viewController: UIViewController) {
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        myAlert.addAction(okAction)
        viewController.present(myAlert, animated: true, completion: nil)
    }

}
