//
//  Cells.swift
//  UniversalDictionary
//
//  Created by Debanik Purkayastha on 1/11/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation
import UIKit
import SpreadsheetView

class TextCell: Cell {
    
    var translation: Translation?
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ButtonCell: Cell {
    
}
