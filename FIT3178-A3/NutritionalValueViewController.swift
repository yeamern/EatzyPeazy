//
//  NutritionalValueViewController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 8/6/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class NutritionalValueViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var nutritionalValues: UILabel!
    
    override func viewDidLoad() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search nutritional value"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
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
