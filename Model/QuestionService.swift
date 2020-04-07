//
//  QuestionService.swift
//  Learn English
//
//  Created by Idriss Souissi on 22/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import Foundation

class QuestionService {
    
    //MARK: - Propreties
    
    var items = [String]()
    var elementsAlreadyChoose = [String]()
    var indexOfRightAnswer = Int()
    var allAnswers = [Bool]()
   
    //MARK: - Methods
    
    ///Create a random array of values and return four elements to choice in quizz
    private func createRandomArrayOfValues(dictionary: NSDictionary , indexOfLevel: Int)-> [String] {
        
        var arrayShuffled :[String] = []
        guard let keys = dictionary.allKeys as? [String] else {return [""]}
        guard let values = dictionary.allValues as? [String] else {return [""]}
        
        if indexOfLevel == 1 {
            arrayShuffled = keys.shuffled()
        }else{
            arrayShuffled = values.shuffled()
        }
        return arrayShuffled.dropLast(keys.count - 4)
    }
    
    /// Write a question with a  random elements
   func createQuestion(dictionary: NSDictionary, indexOfLevel: Int)-> String{
    
        var randomElement: String = String()
        repeat {
            items = createRandomArrayOfValues(dictionary: dictionary, indexOfLevel: indexOfLevel)
            randomElement = items.randomElement() ?? String()
        }while elementsAlreadyChoose.contains(randomElement)
        elementsAlreadyChoose.append(randomElement)
        indexOfRightAnswer = items.firstIndex(of: randomElement) ?? 0
       
        return writeQuestion(indexOfLevel: indexOfLevel, elementsAlreadyChoose: elementsAlreadyChoose)
    }
    
    /// Write question in english or french according to level of theme
    private func writeQuestion(indexOfLevel: Int, elementsAlreadyChoose: [String])-> String {
        if indexOfLevel == 1 {
            return "Where is the \(elementsAlreadyChoose.last ?? String()) ?"

        }else{
            return "Où est \(elementsAlreadyChoose.last ?? String()) ?"
        }
    }
    
    /// Count answers and return a function according to the number of answers
    func countAnswer(data: NSDictionary, item: IndexPath.Index, isFinished: @escaping () -> Void, refresh: @escaping () -> Void) {
          
          allAnswers.append(indexOfRightAnswer == item ? true : false)
        
          if allAnswers.count >= data.count {
              isFinished()
            
          } else {
              refresh()
          }
      }
    
    /// Initialize all propreties except the indexOfRightAnswer
    func restart() {
        allAnswers.removeAll()
        elementsAlreadyChoose.removeAll()
        items.removeAll()
    }
}
