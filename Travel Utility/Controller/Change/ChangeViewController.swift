//
//  ChangeController.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import UIKit

class ChangeViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak private var pickerTo: UIPickerView!
    @IBOutlet weak private var pickerFrom: UIPickerView!
    @IBOutlet weak private var deviseTextField: UITextField!
    @IBOutlet weak private var deviseConvert: UILabel!

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
    // each time view appear the app check the rate change
    // so if there is an error, just change tab et go back to try again
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeService.getChange { (error, devise) in
            if let error = error {
                self.presentAlert(message: error.localizedDescription)
            } else if let devise = devise {
                self.deviseArray = devise
                self.changeService.getSymbols { (error, symbols) in
                    if let error = error {
                        self.presentAlert(message: error.localizedDescription)
                    } else if let symbols = symbols {
                        self.symbols = symbols
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
        pickerFrom.selectRow(Constantes.euro, inComponent: 0, animated: true)
        pickerTo.selectRow(Constantes.usd, inComponent: 0, animated: true)
        inputValue = deviseArray[Constantes.euro].value
        outputValue = deviseArray[Constantes.usd].value
    }

}

    // MARK: - Extensions

extension ChangeViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return deviseArray.count > 0 ? deviseArray.count : 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return symbols.count > 0 ? "\(deviseArray[row].name) \(symbols[deviseArray[row].name]!)" : Constantes.loading
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.tag == 0 ? (inputValue = deviseArray[row].value) : (outputValue = deviseArray[row].value)
        if let devise = Double(deviseTextField.text!) {
            deviseConvert.text = changeService.convertDevise(number: devise, input: inputValue!, output: outputValue!)
        }
    }
}

extension ChangeViewController: UITextFieldDelegate {

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
