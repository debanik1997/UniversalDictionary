//
//  Translation.swift
//  UniversalDictionary
//
//  Created by Debanik Purkayastha on 1/12/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

struct Translation {
    var englishKey: String
    var translations: [String]
    
    init() {
        self.englishKey = ""
        self.translations = [String]()
    }
    
    init(englishKey: String, translations: [String]) {
        self.englishKey = englishKey
        self.translations = translations
    }
}
