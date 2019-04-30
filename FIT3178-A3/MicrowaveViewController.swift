//
//  MicrowaveViewController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 30/4/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class MicrowaveViewController: UIViewController {

    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var recipeW: UITextField!
    @IBOutlet weak var userW: UITextField!
    @IBOutlet weak var answer: UILabel!
    
    
    @IBAction func convert(_ sender: Any) {
        
        // ensure that values entered are valid
        guard let _ = Float(time.text!) else {
            displayMessage(title: "Error", msg: "Please enter an integer or decimal")
            return
        }
        guard let _ = Float(recipeW.text!) else {
            displayMessage(title: "Error", msg: "Please enter an integer or decimal")
            return
        }
        guard let _ = Float(userW.text!) else {
            displayMessage(title: "Error", msg: "Please enter an integer or decimal")
            return
        }
        
        let time1:Int? = Int(time.text!)
        let w1:Int? = Int(recipeW.text!)
        let w2:Int? = Int(userW.text!)
        
        let calculated = (time1! * w1!) / w2!
        
        answer.text = "Food should be placed in your microwave for \(calculated) seconds"
        answer.isHidden = false
    }
    
    func displayMessage(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        answer.isHidden = true
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
