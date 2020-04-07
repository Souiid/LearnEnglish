//
//  ChapterViewController.swift
//  Learn English
//
//  Created by Idriss Souissi on 22/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import UIKit

class ChapterViewController: UIViewController {
    
    //MARK: - Propreties and Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let firestoreService = FirestoreService()
    private let authService = AuthService()
    private var array = [String]()
    private var indexOfVideo = Int()
    private var pathSuffix = String()
   
    //MARK: - Methods and Actions
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ChapterCell", bundle: nil), forCellReuseIdentifier: "ChapterCell")
        checkIfUserIsConnected()
        managedViewsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(UINib.init(nibName: "ChapterCell", bundle: nil), forCellReuseIdentifier: "ChapterCell")
         checkIfUserIsConnected()
         managedViewsData()
    }
    
    //Manage views from correct data according to the age
    private func managedViewsData() {

        firestoreService.downloadUsersData { (name, age) in
             self.titleLabel.text = "Bonjour \(name) \n"
             guard let title = self.titleLabel.text else {return}
            
                if age < 8 {
                    self.titleLabel.text = title + "Apprends l'anglais avec Petit Ours Brun"
                    self.imageView.image = UIImage(named: "PetitOursBrun")
                    self.array = ["Petit Ours Brun a perdu son jouet", "Petit Ours Brun a un accident", "Petit Ours Brun veut un gâteau"]
                }else {
                    self.titleLabel.text = title + "Apprends l'anglais avec Tintin"
                    self.imageView.image = UIImage(named: "tintin_et_milou")
                    self.array = ["Tintin au Tibet Partie 1 Episode 1", "Tintin au Tibet Partie 1 Episode 2", "Tintin au Tibet Partie 1 Episode 3"]
                }
            self.tableView.reloadData()
        }
    }
    
    //Check if user is connected
    private func checkIfUserIsConnected() {
        authService.isUserConnected { (success) in
            if !success {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "Login")
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.isModalInPresentation = true
                self.present(loginVC, animated: true, completion: nil)
            }
        }
    }

    //Send name of video to PlayerViewController via segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let playerVC = segue.destination as? PlayerViewController else {return}
        playerVC.nameOfVideo = array[indexOfVideo]
    }
}

    //MARK: - Extension

extension ChapterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterCell", for: indexPath) as? ChapterCell else {return UITableViewCell()}
        
        let image = array[indexPath.row]
        cell.imageViewCell.image = UIImage(named: image)
        let title = array[indexPath.row]
        cell.titleLabel.text = title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfVideo = indexPath.row
        performSegue(withIdentifier: "segueToPlayerVC", sender: self)
    }
    
    
    
    
}
