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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
