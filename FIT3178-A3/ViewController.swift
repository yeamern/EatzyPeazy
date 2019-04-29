//
//  ViewController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 29/4/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var range: UILabel!
    @IBOutlet weak var bmiSuggested: UILabel!
    @IBOutlet weak var healthy: UILabel!
    
    @IBAction func calculate(_ sender: Any) {
        let weight:Float? = Float(weightField.text!)
        let height:Float? = Float(heightField.text!)
        
        // measure bmi
        let bmi = weight! / ((height!/100) * (height!/100))
        let minWeight = (18.5 * ((height!/100) * (height!/100)))
        let maxWeight = 24.9 * ((height!/100) * (height!/100))
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        range.isHidden = true
        bmiSuggested.isHidden = true
        healthy.isHidden = true
    }


}

