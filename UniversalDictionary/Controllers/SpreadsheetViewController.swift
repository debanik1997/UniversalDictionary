//
//  SpreadsheetViewController.swift
//  UniversalDictionary
//
//  Created by Debanik Purkayastha on 1/9/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import UIKit
import SpreadsheetView
import Firebase
import FirebaseFirestore
import PopupDialog

class SpreadsheetViewController: UIViewController {
    weak var spreadsheetView: SpreadsheetView!
    
    var codes = ["ben": "Bengali", "spa": "Spanish", "aar": "Afar"]
    var translationsDict = [Translation]()
    var universalDictionary = UniversalDictionary(translations: [Translation]())
    var translationsRef: DocumentReference!
    var languageCode: String?
    init(languageCode: String) {
        super.init(nibName: nil, bundle: nil)
        self.languageCode = languageCode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let spreadsheetView = SpreadsheetView(frame: .zero)
        spreadsheetView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(spreadsheetView)
        NSLayoutConstraint.activate([
            spreadsheetView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            spreadsheetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            spreadsheetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            spreadsheetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        self.spreadsheetView = spreadsheetView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.spreadsheetView.dataSource = self
        self.spreadsheetView.delegate = self
        spreadsheetView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        spreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        self.translationsRef = Firestore.firestore().collection("universaldictionary").document("translations")
        self.getDictionary(translationRef: self.translationsRef)
//        self.getDictionaryTest()
    }
    
//    func getDictionaryTest() {
//        self.translationsDict = [Translation]()
//        translationsDict.append(Translation(englishKey: "hello", translations: ["hola"]))
//        translationsDict.append(Translation(englishKey: "goodbye", translations: ["adios"]))
//    }
    func getDictionary(translationRef: DocumentReference) {
        translationsRef.collection(self.languageCode!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var translations = [Translation]()
                for document in querySnapshot!.documents {
                    let engWord = document.data()["englishWord"] as! String
                    let translationArray = document.data()["translation"] as! [String]
                    let id = document.documentID
                    let translation = Translation(id: id, englishKey: engWord, translations: translationArray)
                    translations.append(translation)
                }
                self.translationsDict = translations
                self.translationsDict.sort { (lhs, rhs) in return lhs.englishKey < rhs.englishKey }
                DispatchQueue.main.async {
                    self.spreadsheetView.reloadData()
                }
            }
        }
    }
    
    func showPopup(translation: Translation, id: String) {
        let popupVC = PopupViewController(nibName: nil, bundle: nil)
        let popup = PopupDialog(
            viewController: popupVC,
            buttonAlignment: .horizontal,
            tapGestureDismissal: false) {
        }
        let cancel = DefaultButton(title: "Cancel") {
            print("User did not select an ingredient")
        }
        
        let add = DefaultButton(title: "Add") {
            guard let translationText = popupVC.getNewTranslation() else { return }
            self.addTranslation(translationText: translationText, id: id)
            popup.dismiss()
        }
        popupVC.translation = translation
        popup.addButton(cancel)
        popup.addButton(add)
        popupVC.popup = popup
        self.present(popup, animated: true, completion: nil)
    }
    
    func addTranslation(translationText: String, id: String) {
        let docRef = self.translationsRef.collection(self.languageCode!).document(id)
        docRef.updateData([
            "translation": FieldValue.arrayUnion([translationText])
        ])
//        let index = self.translationsDict.lastIndex(where: )
        
//        let idxPath = IndexPath(item: index!, section: 0)
//        DispatchQueue.main.async {
//            self.spreadsheetView.reloadData()
//        }
    }
}

extension SpreadsheetViewController: SpreadsheetViewDataSource {
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 2
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return translationsDict.count + 1
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if case 0 = column {
            return 205
        } else if case 1 = column{
            return 205
        } else {
            return 210
        }
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if case 0 = row {
            return 40
        } else {
            return 60
        }
    }

    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier:
            String(describing: TextCell.self), for: indexPath) as! TextCell
        if (indexPath.row == 0) {
            if indexPath.column == 0 {
                cell.label.text = "English"
            } else {
                cell.label.text = self.codes[self.languageCode ?? ""] ?? "Unknown language"
            }
            cell.backgroundColor = .cyan
            return cell
        } else {
            let translation = self.translationsDict[indexPath.row-1]
            cell.translation = translation
            if (indexPath.column == 0) {
                cell.label.text = translation.englishKey
            } else {
                cell.label.text = translation.translations[0]
            }
            return cell
        }
    }
}

extension SpreadsheetViewController: SpreadsheetViewDelegate {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            return
        }
        let engWord = self.translationsDict[indexPath.row-1].englishKey
        let translations = self.translationsDict[indexPath.row-1].translations
        let translation = self.translationsDict[indexPath.row-1]
        self.translationsRef.collection("ben").whereField("englishWord", isEqualTo: engWord)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        print(translations)
                        self.showPopup(translation: translation, id: document.documentID)
                    }
                }
        }
    }
}

//গোল
