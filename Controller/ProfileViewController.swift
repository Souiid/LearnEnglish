//
//  ProfileViewController.swift
//  Learn English
//
//  Created by Idriss Souissi on 22/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Propreties and Outlets
    
    private let firestoreService = FirestoreService()
    private let authService = AuthService()
    private let alert = Alert()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    //MARK: - Methods and Actions
       
    override func viewDidLoad() {
        super.viewDidLoad()
        firestoreService.downloadUsersData { (name, age) in
            self.nameTextField.placeholder = name
            self.ageTextField.placeholder = String(age)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         firestoreService.downloadUsersData { (name, age) in
            self.nameTextField.placeholder = name
            self.ageTextField.placeholder = String(age)
        }
    }
       
    //Disconnect a user
    @IBAction func logOut() {
           
        authService.signOut { (success) in
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "Login")
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.isModalInPresentation = true
            self.present(loginVC, animated: true, completion: nil)
            self.tabBarController?.selectedIndex = 0
        }
    }
       
    //Modify name or age of a user
    @IBAction func modifyUserData() {
        var age = ""
        var name = ""
        if nameTextField.text == "" && ageTextField.text == "" {
            presentAlert(message: "Il faut remplir au moins l'un des deux champs de texte", title: "Erreur")
            return
        }
        
        guard let agePlaceHolder = ageTextField.placeholder else {return}
        guard let namePlaceHolder = nameTextField.placeholder else {return}
        
        name = nameTextField.text == "" ? namePlaceHolder : nameTextField.text ?? ""
        age = ageTextField.text == "" ? agePlaceHolder : ageTextField.text ?? ""
        
        guard let ageInt = Int(age) else {return}

        let isDataCorrect = firestoreService.updateUsersData(name: name, age: ageInt)
            if isDataCorrect {
                presentAlert(message: "Modification Validée", title: "OK")
                ageTextField.placeholder = age
                nameTextField.placeholder = name
                ageTextField.text = ""
                nameTextField.text = ""
            }else {
                presentAlert(message: "L'age doit être compris entre 1 et 120 ans et il faut un nom de minimum 2 caractères", title: "Erreur")
            }
    }
    
    //Dismiss keyboard when user tap on screen
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
    }
       
    //Dismiss keyboard when user tap on its button 'Continue'
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Present an alert
    private func presentAlert(message: String, title: String) {
        alert.showAlert(title: title, message: message, viewController: self)
    }

}
