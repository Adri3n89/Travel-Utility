//
//  ChangeController.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import UIKit

class ChangeController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var pickerTo: UIPickerView!
    @IBOutlet weak var pickerFrom: UIPickerView!
    @IBOutlet weak var deviseTextField: UITextField!
    @IBOutlet weak var deviseConvert: UILabel!

    // MARK: - Variable

    let changeService = ChangeService()

    // MARK: - Private Variables

    private var result: ChangeResponse?
    private var inputValue: Double?
    private var outputValue: Double?
    private var symbols: [String:String] = [:] {
        didSet {
            if deviseArray.count > 0 {
                actuPicker()
            }
        }
    }

    private var deviseArray: [Devise] = [] {
        didSet {
            if symbols.count > 0 {
                actuPicker()
            }
        }
    }

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }

    // MARK: - ViewWillAppear
    // each time view appear the app check the rate change, so if there is an error, just change tab et go back to try again
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeService.getChange { (error, devise) in
            DispatchQueue.main.async {
                if let error = error {
                    self.presentAlert(message: error.localizedDescription)
                } else if let devise = devise {
                    self.deviseArray = devise
                    self.changeService.getSymbols { (error, symbols) in
                        DispatchQueue.main.async {
                            if let error = error {
                                self.presentAlert(message: error.localizedDescription)
                            } else if let symbols = symbols {
                                self.symbols = symbols
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Private Methods

    private func setupOutlets() {
        pickerTo.dataSource = self
        pickerTo.delegate = self
        pickerFrom.dataSource = self
        pickerFrom.delegate = self
        deviseTextField.delegate = self
    }

    // set the pickers on EURO -> USD by default
    private func actuPicker() {
        pickerFrom.reloadAllComponents()
        pickerTo.reloadAllComponents()
        pickerFrom.selectRow(46, inComponent: 0, animated: true)
        pickerTo.selectRow(149, inComponent: 0, animated: true)
        inputValue = deviseArray[46].value
        outputValue = deviseArray[149].value
    }

}

    // MARK: - Extensions

extension ChangeController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if deviseArray.count != 0 {
            return deviseArray.count
        } else {
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if symbols.count != 0 {
            return "\(deviseArray[row].name) \(symbols[deviseArray[row].name]!)"
        } else {
            return "loading"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            inputValue = deviseArray[row].value
        } else {
            outputValue = deviseArray[row].value
        }
        if let devise = Double(deviseTextField.text!) {
            deviseConvert.text = changeService.convertDevise(number: devise, input: inputValue!, output: outputValue!)
        }
    }
}

extension ChangeController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeKeyboard()
        return true
    }

    // perfom live conversion during editing
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let devise = Double(deviseTextField.text!) {
            deviseConvert.text = changeService.convertDevise(number: devise, input: inputValue!, output: outputValue!)
        }
    }
}
