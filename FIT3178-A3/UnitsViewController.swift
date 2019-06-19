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
    var indicator = UIActivityIndicatorView()
    
    var sourcePickerData: [String] = [String]()
    var targetPickerData: [String] = [String]()
    

    @IBAction func convertButton(_ sender: Any) {
        // ensure that values are valid
        guard let _ = Float(quantityField.text!) else {
            displayMessage(title: "Error", msg: "Please enter an integer or decimal")
            return
        }
        
        let quantity:Float? = Float(quantityField.text!)
        
        let searchString = "https://neutrinoapi.com/convert?user-id=yeamern&api-key=x5bcUrn14QYpWv9852nK2B3Oj1OA9S9gMNLp3LYidVMxoqF0&from-value=\(quantityField.text!)&from-type=\(sourceField.text!)&to-type=\(targetField.text!)"
        
        let url = URL(string: searchString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)
        let converter = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
            if let error = error {
                DispatchQueue.main.async {
                    self.displayMessage(title: "Error", msg: error.localizedDescription)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let unitsData = try decoder.decode(UnitsData.self, from: data!)
                if let valid = unitsData.valid, !valid {
                    DispatchQueue.main.async {
                        self.displayMessage(title: "Error", msg: "Specified units not supported. Try a different unit.")
                    }
                    return
                }
                
                if let results = unitsData.result {
                    DispatchQueue.main.async {
                        let display = "\(self.quantityField.text!)\(self.sourceField.text!) = \(results)\(self.targetField.text!)"
                        self.answerLabel.text = display
                    }
                }
                
            } catch let err {
                DispatchQueue.main.async {
                    self.displayMessage(title: "Error", msg: err.localizedDescription)
                }
            }
        }
        converter.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
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
