//
//  QuizzLessonViewController.swift
//  Learn English
//
//  Created by Idriss Souissi on 22/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import UIKit

final class QuizzLessonViewController: UIViewController {
    
    //MARK: - Propreties and Outlets

  
    private let dictionaryService = DictionaryService()
    private let questionService = QuestionService()
    private let firestoreService = FirestoreService()
    private let alert = Alert()
     
    private var dictionary = NSDictionary()
    private var keys = [String]()
    private var nameOfCategorie = ""
    private var numberToProgress = Float()
    var indexOfDictionary = 0
    private var indexOfLevel = 1
    private let arrayOfCategorie = ["color", "animal", "number", "house", "school"]
    var itemsLevel : [String: Int]?
     
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var goToNextLevelButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var progressView: UIProgressView!
    
    //MARK: - Methods and Actions
     
     override func viewDidLoad() {
         super.viewDidLoad()
        
        //Initialize views and get correct dictionary
         progressView.progress = 0.0
         dictionary = dictionaryService.getDictionary(indexOfKey: indexOfDictionary)
         restartButton.isHidden = true
         goToNextLevelButton.isHidden = true
         nameOfCategorie = arrayOfCategorie[indexOfDictionary]
         guard let allKeys = dictionary.allKeys as? [String] else {return}
        
         keys = allKeys
         collectionView.register(UINib.init(nibName: "QuestionViewCell", bundle: nil),
         forCellWithReuseIdentifier: "QuestionViewCell")
         guard let itemsLevel = itemsLevel else {return}
         indexOfLevel = itemsLevel[nameOfCategorie] ?? 0
     
        questionLabel.text = questionService.createQuestion(dictionary: dictionary, indexOfLevel: indexOfLevel)
    }
     
    //Create a new question
    private func createQuestion() {
        questionLabel.text = questionService.createQuestion(dictionary: dictionary, indexOfLevel: indexOfLevel)
         collectionView.reloadData()
     }
     
    //Present an alert
    private func presentAlert(message: String) {
        alert.showAlert(title: "Bien", message: message, viewController: self)
     }
     
     //Manage end of a quizz and present different views and alert according to result
     private func manageEndOfQuizz(numberOfGoodAnswer: Int) {
         if numberOfGoodAnswer == keys.count {
             presentAlert(message: "Tu as \(numberOfGoodAnswer) bonne réponse. Bravo tu as réussi !")
             goToNextLevelButton.isHidden = false
            
            if indexOfLevel == 1 {
                 goToNextLevelButton.setTitle("Passer au niveau 2", for: .normal)
             }else {
                 goToNextLevelButton.setTitle("Re-passer au niveau 1", for: .normal)
             }
             
         }else {
             presentAlert(message: "Tu as \(numberOfGoodAnswer) bonne réponse. Encore un effort !")
         }
        
         restartButton.isHidden = false
    }
     
    //Initialize views and create a new question
     private func restart() {
         restartButton.isHidden = true
         goToNextLevelButton.isHidden = true
         progressView.progress = 0.0
         questionService.restart()
         createQuestion()
     }
     
    //Restart
    @IBAction func restartQuizz() {
         restart()
     }
     
     //Go to next level (1 or 2 according to actual level)
     @IBAction func goToNextLevel() {
         if indexOfLevel == 1 {
             indexOfLevel = 2
         }  else {
             indexOfLevel = 1
         }
         guard var itemsLevel = itemsLevel else {return}
         itemsLevel[nameOfCategorie] = indexOfLevel
         firestoreService.uploadItemsLevel(dictionary: itemsLevel)
         restart()
     }
}

    //MARK: - Extension

extension QuizzLessonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionService.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionViewCell", for: indexPath) as? QuestionViewCell else {return UICollectionViewCell()}
        
        if indexOfLevel == 1 {
            let name = "\(nameOfCategorie)\(questionService.items[indexPath.item])"
            cell.imageView.isHidden = false
            cell.label.isHidden = true
            cell.imageView.image = UIImage(named: name)
       }else {
            cell.imageView.isHidden = true
            cell.label.isHidden = false
            cell.label.text = dictionaryService.getKeyFromValue(dictionary: dictionary, value: questionService.items[indexPath.item])
       }
       return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        progressView.progress += 1.0 / Float(keys.count)
        
        questionService.countAnswer(data: dictionary, item: indexPath.item, isFinished: {
            var tempResult = self.questionService.allAnswers
             tempResult.removeAll(where: { $0 == false })
            self.manageEndOfQuizz(numberOfGoodAnswer: tempResult.count)
        }) {
            self.createQuestion()
        }
    }
}
