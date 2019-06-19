//
//  ExpiryTableViewController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 6/5/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class ExpiryTableViewController: UITableViewController, DatabaseListener {
    
    let CELL_ITEM = "itemCell"
    var expiryList: [Expiry] = []
    weak var databaseController: DatabaseProtocol?
    var listenerType = ListenerType.expiry
    
    func onListChange(change: DatabaseChange, items: [Item]) {
    }
    
    func onExpiryChange(change: DatabaseChange, items: [Expiry]) {
        expiryList = items
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
    }
    
    // Add the view controller as a listener of the database controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    // Remove the view controller as a listener of the database controller
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expiryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemCell = tableView.dequeueReusableCell(withIdentifier: CELL_ITEM, for: indexPath) as! ExpiryTableViewCell
        let item = expiryList[indexPath.row]
        
        itemCell.itemLabel.text = item.name
        itemCell.dateLabel.text = item.date!.description
        itemCell.dateLabel.textColor = UIColor.black
        
        if (item.date! as Date) < Date() {
            itemCell.dateLabel.textColor = UIColor.red
        }
        
        return itemCell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            databaseController?.deleteExpiry(item: expiryList[indexPath.row])
             self.expiryList.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
