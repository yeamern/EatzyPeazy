//
//  TimerViewController.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 04/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//
// code adapted from : https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startLabel: UIButton!
    @IBOutlet weak var pauseLabel: UIButton!
    
    @IBOutlet weak var hourField: UITextField!
    @IBOutlet weak var minuteField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    
    // set 	0 as starting value
    var hours = 0
    var minutes = 0
    var seconds = 0
    var timer = Timer()
    
    // ensure only one timer is running
    var isTimerRunning = false
    
    // keep track if pause button is tapped (if it is allowed to resume)
    var resumeTapped = false
    
    @IBAction func startButton(_ sender: Any) {
        
        // if there is no input, set it to 00
        if secondField.text?.count == 0 {
            secondField.text = "00"
        }
        if minuteField.text?.count == 0 {
            minuteField.text = "00"
        }
        if hourField.text?.count == 0 {
            hourField.text = "00"
        }
        
        // pad the text field if the number is a single digit number
        if secondField.text?.count == 1 {
            secondField.text = "0\(secondField.text!)"
        }
        if minuteField.text?.count == 1 {
            minuteField.text = "0\(minuteField.text!)"
        }
        if hourField.text?.count == 1 {
            hourField.text = "0\(hourField.text!)"
        }
        
        hours = Int(hourField.text!)!
        minutes = Int(minuteField.text!)!
        seconds = Int(secondField.text!)!
        
        // display error if input is more than 59 for each minute and second text field
        guard minutes < 60 else {
            displayMessage(title: "Error", msg: "Minutes must be less than 60")
            return
        }
        guard seconds < 60 else {
            displayMessage(title: "Error", msg: "Seconds must be less than 60")
            return
        }
        
        
        // run timer and disable the start button, and the text fields
        if isTimerRunning == false {
            runTimer()
            self.startLabel.isEnabled = false
            hourField.isEnabled = false
            minuteField.isEnabled = false
            secondField.isEnabled = false
        }
    }
    
    // if pause button is tapped (resumeTapped is false), timer will be stopped
    // if not, timer will continue
    @IBAction func pauseButton(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseLabel.setTitle("Resume", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            self.pauseLabel.setTitle("Pause", for: .normal)
        }
    }
    
    // stop the timer and reset to 0
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        secondField.text = ""
        minuteField.text = ""
        hourField.text = ""
        //timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseLabel.isEnabled = false
        startLabel.isEnabled = true
        pauseLabel.setTitle("Pause", for: .normal)
        
        // enable the text fields
        hourField.isEnabled = true
        minuteField.isEnabled = true
        secondField.isEnabled = true
        
        // reset everything
        resumeTapped = false
    }
    
    // initialize timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseLabel.isEnabled = true
    }
    
    // count down the seconds and show it on the label
    @objc
    func updateTimer() {
        
        if seconds < 1 {
            if minutes < 1 {
                if hours < 1 {
                    seconds = 0
                    secondField.text = String(seconds)
                    timer.invalidate()
                    displayMessage(title: "Time's up!", msg: "")
                } else {
                    hours -= 1
                    minutes = 59
                    seconds = 59
                    hourField.text = String(hours)
                    minuteField.text = String(minutes)
                    secondField.text = String(seconds)
                }
            } else {
                minutes -= 1
                seconds = 59
                minuteField.text = String(minutes)
                secondField.text = String(seconds)
            }
        } else {
            seconds -= 1
            secondField.text = String(seconds)
        }
        
        // pad the text field if the number is a single digit number
        if secondField.text?.count == 1 {
            secondField.text = "0\(secondField.text!)"
        }
        if minuteField.text?.count == 1 {
            minuteField.text = "0\(minuteField.text!)"
        }
        if hourField.text?.count == 1 {
            hourField.text = "0\(hourField.text!)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseLabel.isEnabled = false
    }
    
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


