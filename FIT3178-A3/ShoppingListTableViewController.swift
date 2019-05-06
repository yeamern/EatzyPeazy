//
//  ShoppingListTableViewController.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 05/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, DatabaseListener {
    func onListChange(change: DatabaseChange, items: [Item]) {
        shoppingList = items
        tableView.reloadData()
    }
    
    
    let CELL_ITEM = "itemCell"
    
    var shoppingList: [Item] = []
    
    weak var databaseController: DatabaseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    var listenerType = ListenerType.item

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: CELL_ITEM, for: indexPath)
        let item = shoppingList[indexPath.row]
        
        itemCell.textLabel?.text = item.name

        return itemCell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            databaseController?.deleteItem(item: shoppingList[indexPath.row])
            // self.shoppingList.remove(at: indexPath.row)
            // tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSegue" {
            let destination = segue.destination as! AddItemViewController
            destination.addItemDelegate = self
        }
    }

    func addItem(newItem: ShoppingItem) -> Bool {
        shoppingList.append(newItem)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: shoppingList.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        tableView.reloadSections([0], with: .automatic)
        return false
    }
    */
        
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

}
