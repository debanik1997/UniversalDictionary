//
//  Translation.swift
//  UniversalDictionary
//
//  Created by Debanik Purkayastha on 1/12/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

struct Translation {
    var id: String
    var englishKey: String
    var translations: [String]
    
    init() {
        self.id = ""
        self.englishKey = ""
        self.translations = [String]()
    }
    
    init(id: String, englishKey: String, translations: [String]) {
        self.id = id
        self.englishKey = englishKey
        self.translations = translations
    }
}
