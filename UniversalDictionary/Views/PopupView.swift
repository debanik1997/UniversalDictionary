//
//  IngredientPopupView.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/23/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
//import iOSDropDown
 
class PopupView: UIView {

    // The title label
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    // The table view
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .gray
        tf.placeholder = "Add a translation"
        return tf
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addSubview(tableView)
        
        // Setup constraints
        heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        addSubview(titleLabel)
        let titleLabelConstraints = [
           titleLabel.topAnchor.constraint(equalTo: topAnchor),
           titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
           titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 100),
            tableView.widthAnchor.constraint(equalTo: widthAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
        
        addSubview(textField)
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(textFieldConstraints)
    }
}
