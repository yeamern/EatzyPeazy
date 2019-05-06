//
//  AddItemViewController.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 05/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    weak var databaseController: DatabaseProtocol?
    
    @IBOutlet weak var itemField: UITextField!
    
    @IBAction func add(_ sender: Any) {
        if itemField.text != "" {
            let item = itemField.text!
    
            let _ = databaseController!.addItem(name: item)
            navigationController?.popViewController(animated: true)
            return
        }
        
        if itemField.text == "" {
            displayMessage(title: "Error", msg: "Please ensure there is an item to be added")
        }
    }
    
    func displayMessage(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController

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
