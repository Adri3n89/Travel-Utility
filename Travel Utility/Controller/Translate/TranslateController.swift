//
//  TranslateController.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import UIKit

class TranslateController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak private var pickerFrom: UIPickerView!
    @IBOutlet weak private var pickerTo: UIPickerView!
    @IBOutlet weak private var textViewFrom: UITextView!
    @IBOutlet weak private var textViewTo: UITextView!
    @IBOutlet weak private var translateButton: UIButton!

    // MARK: - Variable

    let translateService = TranslateService()

    // MARK: - Private Variables
    // caculated variable that to action when a new value is set
    // here is to go to the English language and reload
    private var outputLanguages: [Langue] = [] {
        didSet {
            pickerTo.reloadAllComponents()
            pickerTo.selectRow(english, inComponent: 0, animated: true)
            target = outputLanguages[english].language
        }
    }
    // here is to go to the Auto-Detect and reload
    private var inputLanguages: [Langue] = [Langue(language: "auto", name: "Auto-Detect")] {
        didSet {
            pickerFrom.reloadAllComponents()
            pickerFrom.selectRow(0, inComponent: 0, animated: true)
            source = inputLanguages[0].language
        }
    }
    // private variable to set the source and target for the API
    private var source = ""
    private var target = ""
    private let english = 21
    private let loading = "LOADING"
    private let translate = "TRANSLATE"

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        initPickers()
        addTap()
    }

    // MARK: - ViewWillAppear
    // each time view appear the app check the languages
    // so if there is an error, just change tab et go back to try again
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translateService.getAvailableLanguages { (error, languages) in
            if let error = error {
                self.presentAlert(message: error.localizedDescription)
            } else if let languageArray = languages {
                self.inputLanguages += languageArray
                self.outputLanguages = languageArray
            }
        }
    }

    // MARK: - Private Methods

    private func initPickers() {
        pickerFrom.dataSource = self
        pickerFrom.delegate = self
        pickerTo.dataSource = self
        pickerTo.delegate = self
    }

    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }

    // MARK: - IBActions
    // disable the translate button to only have 1 request at time
    // check the source to choose wich URL is need for the request
    @IBAction func translatePushed(_ sender: Any) {
        closeKeyboard()
        translateButton.titleLabel?.text = loading
        translateButton.isEnabled = false
        let encodedString = textViewFrom.text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if source == "auto" {
            translateService.translateDetect(text: encodedString!, target: target) { (error, translatedString) in
                if let error = error {
                    self.presentAlert(message: error.localizedDescription)
                } else if let translation = translatedString {
                    self.textViewTo.text = translation
                }
                self.translateButton.titleLabel?.text = self.translate
                self.translateButton.isEnabled = true
            }
        } else  {
            translateService.translate(text: encodedString!, target: target, source: source) { (error, translatedString) in
                if let error = error {
                    self.presentAlert(message: error.localizedDescription)
                } else if let translation = translatedString {
                    self.textViewTo.text = translation
                }
                self.translateButton.titleLabel?.text = self.translate
                self.translateButton.isEnabled = true
            }
        }
    }

}

// MARK: - PickerDataSource Extension
extension TranslateController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return inputLanguages.count > 0 ? inputLanguages.count : 1
        } else {
            return outputLanguages.count > 0 ? outputLanguages.count : 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return inputLanguages.count > 0 ? inputLanguages[row].name : loading
        } else {
            return outputLanguages.count > 0 ? outputLanguages[row].name : loading
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            if inputLanguages.count > 0 {
                source = inputLanguages[row].language
            }
        } else {
            if outputLanguages.count > 0 {
                target = outputLanguages[row].language
            }
        }
    }

}

// MARK: - PickerDelegate Extension
extension TranslateController: UIPickerViewDelegate {}

// MARK: - TextField Extension
extension TranslateController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeKeyboard()
        return true
    }
}

