//
//  IngredientPopupViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/23/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import PopupDialog

final class PopupViewController: UIViewController {
    
    public weak var popup: PopupDialog?
    
    fileprivate var baseView: PopupView {
        return view as! PopupView
    }
    
    public var translation = Translation() {
        didSet { baseView.titleLabel.text = "English Word: \(translation.englishKey)"}
    }

    override func loadView() {
        view = PopupView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.titleLabel.text = "Add an Ingredient"
        // Setup tableView
        baseView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        baseView.tableView.dataSource = self
    }
    
    func getNewTranslation() -> String? {
//        return baseView.newTranslationText.
        return baseView.textField.text
    }
}

extension PopupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translation.translations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = translation.translations[indexPath.row]
        return cell
    }
}
