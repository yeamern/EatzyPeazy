//
//  AddExpiryViewController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 6/5/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit
import UserNotifications

class AddExpiryViewController: UIViewController {

    var expiry: Expiry?
    weak var databaseController: DatabaseProtocol?
    
    @IBOutlet weak var itemField: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!

    @IBAction func addExpiry(_ sender: Any) {
        
        let item = itemField.text!
        
        // Item must not be empty
        guard item != "" else {
            displayMessage(title: "Error", msg: "Enter an item")
            return
        }
        
        // Date must not be in the past
        if dateField.date < Date() {
            displayMessage(title: "Error", msg: "Please enter a valid date")
            return
        }
        
        if itemField.text != "" {
            
            let _ = databaseController!.addExpiry(name: item, date: dateField.date)
            
            // notifications
            // code reffered from - http://www.thomashanning.com/push-notifications-local-notifications-tutorial/
            
            let content = UNMutableNotificationContent()
            content.title = "Food expiring soon!"
            content.body = "\(item) expires in 1 day"
            content.sound = UNNotificationSound.default
            
            let triggerDate = Calendar.current.date(byAdding: .second, value: -86400, to: dateField.date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerDate!), repeats: false)
            let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

            navigationController?.popViewController(animated: true)
            displayMessagePop(title: "Saved", msg: "Item and expiry added")
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the databse controller once form the App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
        // Show the details of the item
        if expiry != nil {
            itemField.text = expiry!.name!
            dateField.date = expiry!.date! as Date
        }
    }
    
    // Display a message and pop back to the previous view
    func displayMessagePop(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Display a message
    func displayMessage(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
