//
//  UnitsViewController.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 27/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class UnitsViewController: UIViewController{

    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var sourceField: UITextField!
    @IBOutlet weak var targetField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    var sourcePickerData: [String] = [String]()
    var targetPickerData: [String] = [String]()
    

    @IBAction func convertButton(_ sender: Any) {
        // ensure that values are valid
        guard let _ = Float(quantityField.text!) else {
            displayMessage(title: "Error", msg: "Please enter an integer or decimal")
            return
        }
        
        let quantity:Float? = Float(quantityField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func displayMessage(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return sourcePickerData.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent componenet: Int) -> String? {
//        return sourcePickerData[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
