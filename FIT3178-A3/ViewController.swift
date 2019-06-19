//
//  ViewController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 29/4/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

// BMI view controller
class ViewController: UIViewController {
    
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var range: UILabel!
    @IBOutlet weak var bmiSuggested: UILabel!
    @IBOutlet weak var healthy: UILabel!
    
    @IBAction func calculate(_ sender: Any) {
        
        // ensure that values are valid
        guard let _ = Float(weightField.text!) else {
            displayMessage(title: "Error", msg: "Please enter an integer or decimal")
            return
        }
        guard let _ = Float(heightField.text!) else {
            displayMessage(title: "Error", msg: "Please enter an integer or decimal")
            return
        }
        
        
        let weight:Float? = Float(weightField.text!)
        let height:Float? = Float(heightField.text!)
        
        // measure bmi and suggested healthy weight range
        let bmi = weight! / ((height!) * (height!))
        let minWeight = (18.5 * ((height!) * (height!)))
        let maxWeight = 24.9 * ((height!) * (height!))
        bmiSuggested.text = "Your body mass index is \(String(format: "%.2f", bmi)). The suggested healthy weight range would be \(String(format: "%.2f",minWeight)) - \(String(format: "%.2f",maxWeight)) kg."
        
        // show the range
        if(bmi < 18.5){
            range.text = "Underweight"
        }
        else if(bmi > 24.9){
            range.text = "Overweight"
        }
        else{
            range.text = "Healthy"
        }
        
        range.isHidden = false
        bmiSuggested.isHidden = false
        healthy.isHidden = false
    }
    
    func displayMessage(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        range.isHidden = true
        bmiSuggested.isHidden = true
        healthy.isHidden = true
    }


}

