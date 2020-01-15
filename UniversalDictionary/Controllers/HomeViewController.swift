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
        button.backgroundColor = .cyan
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
        self.view.backgroundColor = .white
    }
    
    @objc func buttonClicked(sender : UIButton){
        self.navigationController!.pushViewController(SpreadsheetViewController(), animated: true)
    }
}

