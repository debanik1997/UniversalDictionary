//
//  HomeViewController.swift
//  UniversalDictionary
//
//  Created by Debanik Purkayastha on 1/14/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let label = UILabel()
    let textField = UITextField()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        button.backgroundColor = .red
        button.setTitle("Get Dictionary", for: .normal)
        button.titleLabel?.textColor = .black
        let buttonConstraints = [
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        textField.placeholder = "Enter 3 digit language code (lowercase)..."
        let textFieldConstraints = [
           textField.widthAnchor.constraint(equalToConstant: 300),
           textField.heightAnchor.constraint(equalToConstant: 100),
           textField.bottomAnchor.constraint(equalTo: button.topAnchor),
           textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
       ]
        NSLayoutConstraint.activate(textFieldConstraints)
        self.view.backgroundColor = .lightGray
    }
    
    @objc func buttonClicked(sender : UIButton){
        if (textField.text != nil || textField.text != "") {
            self.navigationController!.pushViewController(SpreadsheetViewController(languageCode: textField.text!), animated: true)
        }
    }
}

