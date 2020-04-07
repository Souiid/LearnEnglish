//
//  DictionaryService.swift
//  Learn English
//
//  Created by Idriss Souissi on 22/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import Foundation

class DictionaryService {
    
    ///Get a dictionary from Question.plist
    func getDictionary(indexOfKey: Int)->NSDictionary {
        guard let bundle = Bundle.main.path(forResource: "Question", ofType: "plist") else {return [:]}
           
        guard let arrayPlist = NSArray.init(contentsOfFile: bundle) else {return [:]}
        guard let dictionnaryToUse = arrayPlist[indexOfKey] as? NSDictionary else {return [:]}
        return dictionnaryToUse
    }
    
    ///Get a key from a value in dictionary 
    func getKeyFromValue(dictionary: NSDictionary, value: String)-> String {
        guard let values = dictionary.allValues as? [String] else {return ""}
        guard let keys = dictionary.allKeys as? [String] else {return ""}
        guard let index = values.firstIndex(of: value) else {return ""}
        return keys[index]
    }
    
}
