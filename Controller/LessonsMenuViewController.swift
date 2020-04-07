//
//  LessonsMenuViewController.swift
//  Learn English
//
//  Created by Idriss Souissi on 22/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import UIKit

class LessonsMenuViewController: UIViewController {
    
    //MARK: - Propreties and Outlets

    @IBOutlet weak var collectionView: UICollectionView!
     
    private var indexOfDictionary = 0
    private let arrayOfChoice = ["Couleurs", "Animaux", "Chiffre", "À la maison", "À l'école"]
    private let arrayOfImage = ["multicoloreImage", "animaux", "chiffres", "maison", "cartable"]
    private var itemsLevel = ["": 0]
    private let firestoreService = FirestoreService()
    
    //MARK: - Methods and Actions
     
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "LessonMenuCell", bundle: nil), forCellWithReuseIdentifier: "LessonMenuCell")
    }
     
    override func viewWillAppear(_ animated: Bool) {
        firestoreService.downloadItemsLevel { (itemsLevel) in
            self.itemsLevel = itemsLevel
        }
    }
     
    //Send correct index of dictionary and itemsLevel to QuizzLessonViewController via segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToQuizzLesson" {
            if let quizzLessonVC = segue.destination as? QuizzLessonViewController {
                quizzLessonVC.indexOfDictionary = indexOfDictionary
                quizzLessonVC.itemsLevel = itemsLevel
            }
         }
     }
}

    //MARK: - Extension

extension LessonsMenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfChoice.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonMenuCell", for: indexPath) as? LessonMenuCell else {return UICollectionViewCell()}
        let choice = arrayOfChoice[indexPath.row]
        let image = arrayOfImage[indexPath.row]
        cell.titleLabel.text = choice
        cell.imageView.image = UIImage(named: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexOfDictionary = indexPath.row
        performSegue(withIdentifier: "segueToQuizzLesson", sender: self)
    }
    
}
