//
//  TranslateController.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import UIKit

class TranslateController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var pickerFrom: UIPickerView!
    @IBOutlet weak var pickerTo: UIPickerView!
    @IBOutlet weak var textViewFrom: UITextView!
    @IBOutlet weak var textViewTo: UITextView!
    @IBOutlet weak var translateButton: UIButton!

    // MARK: - Variable

    let translateService = TranslateService()

    // MARK: - Private Variables
    // caculated variable that to action when a new value is set
    // here is to go to the English language and reload
    private var outputLanguages: [Langue] = [] {
        didSet {
            pickerTo.reloadAllComponents()
            pickerTo.selectRow(21, inComponent: 0, animated: true)
            target = outputLanguages[21].language
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

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        initPickers()
        addTap()
    }

    // MARK: - ViewWillAppear
    // each time view appear the app check the languages, so if there is an error, just change tab et go back to try again
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translateService.getAvailableLanguages { (error, languages) in
            DispatchQueue.main.async {
                if let error = error {
                    self.presentAlert(message: error.localizedDescription)
                } else if let languageArray = languages {
                    self.inputLanguages += languageArray
                    self.outputLanguages = languageArray
                }
            }
        }
    }

    // MARK: - Private Methods

    private func initPickers() {
        pickerFrom.delegate = self
        pickerFrom.dataSource = self
        pickerTo.delegate = self
        pickerTo.dataSource = self
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
        translateButton.titleLabel?.text = "LOADING"
        translateButton.isEnabled = false
        let encodedString = textViewFrom.text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if source == "auto" {
            translateService.translateDetect(text: encodedString!, target: target) { (error, translatedString) in
                DispatchQueue.main.async {
                    if let error = error {
                        self.presentAlert(message: error.localizedDescription)
                    } else if let translation = translatedString {
                        self.textViewTo.text = translation
                    }
                    self.translateButton.titleLabel?.text = "TRANSLATE"
                    self.translateButton.isEnabled = true
                }
            }
        } else  {
            translateService.translate(text: encodedString!, target: target, source: source) { (error, translatedString) in
                DispatchQueue.main.async {
                    if let error = error {
                        self.presentAlert(message: error.localizedDescription)
                    } else if let translation = translatedString {
                        self.textViewTo.text = translation
                    }
                    self.translateButton.titleLabel?.text = "TRANSLATE"
                    self.translateButton.isEnabled = true
                }
            }
        }
    }

}

// MARK: - Picker Extension
extension TranslateController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            if inputLanguages.count != 0 {
                return inputLanguages.count
            } else {
                return 1
            }
        } else {
            if outputLanguages.count != 0 {
                return outputLanguages.count
            } else {
                return 1
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            if inputLanguages.count != 0 {
                return inputLanguages[row].name
            } else {
                return "loading"
            }
        } else {
            if outputLanguages.count != 0 {
                return outputLanguages[row].name
            } else {
                return "loading"
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            if inputLanguages.count != 0 {
                source = inputLanguages[row].language
            }
        } else {
            if outputLanguages.count != 0 {
                target = outputLanguages[row].language
            }
        }
    }

}

// MARK: - TextField Extension
extension TranslateController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeKeyboard()
        return true
    }
}

