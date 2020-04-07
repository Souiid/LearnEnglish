//
//  HomeViewController.swift
//  Learn English
//
//  Created by Idriss Souissi on 22/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Propreties and Outlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
     
    private let authService = AuthService()
    private let alert = Alert()
    
    //MARK: - Methods
    
     override func viewDidLoad() {
         super.viewDidLoad()
       
    }
   
    //Connnect a user
     @IBAction func signIn() {
         
        guard let email = emailTextField.text, !email.isEmpty else {
            presentAlert(message: "Remplis le champ de l'email")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
           presentAlert(message: "Remplis le champs du mot de passe")
            return
        }
        
        authService.signIn(email: email, password: password) { (success) in
            if success {
                self.dismiss(animated: true)
                self.performSegue(withIdentifier: "segueToMenu", sender: self)
            }else {
                self.presentAlert(message: "Le mot de passe ou l'email est incorrect \n Vérifies aussi ta connexion internet")
            }
        }
    }
     
     //Create a user
     @IBAction func logIn() {
        performSegue(withIdentifier: "segueToLogIn", sender: self)
     }
    
    //Unwindsegue to Menu (TabBarController)
    @IBAction private func unwindToHomeViewController(_ segue: UIStoryboardSegue) { dismiss(animated: false)
    }
    
    //Dismiss a keyboard when user tap on screen
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    //Dismiss a keyboard when user tap on its button 'Continue'
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Present an alert
    private func presentAlert(message: String) {
        alert.showAlert(title: "Erreur", message: message, viewController: self)
    }
    
    

}
