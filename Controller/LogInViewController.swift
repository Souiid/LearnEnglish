//
//  LogInViewController.swift
//  Learn English
//
//  Created by Idriss Souissi on 22/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Propreties and Outlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
        
    private let authService = AuthService()
    private let alert = Alert()
    private let levelDictionary = ["animal": 1, "color": 1, "house": 1, "number": 1, "school": 1] as NSDictionary
    private var name = ""
      
    //MARK: - Methods and Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    //Create a user
    @IBAction func logIn() {
      
        guard let name = nameTextField.text, !name.isEmpty, let age = ageTextField.text, !age.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            presentAlert(message: "Un des champs n'est pas rempli. Attention ! L'age doit être compris entre 1 et 120 et le nom doit avoir au moins 2 caractères")
            return
        }
        
        guard let ageInt = Int(age) else {return}
            
        authService.logIn(email: email, password: password, age: ageInt, name: name, itemsLevel: levelDictionary) { (success, name) in
            if success {
                self.name = name
                self.performSegue(withIdentifier: "UnwindToHomeViewController", sender: nil)
            }else {
                self.presentAlert(message: "L'email est déja pris ou incorrecr\n Il doit être sous la forme exemple@mail.com . Le mot de passe doit être au moins de 6 caractères\n Vérifies aussi ta connexion internet")
            }
        }
    }
    
    //Dismiss a keyboard when user tap on screen
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
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
