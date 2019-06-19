//
//  NutritionalValueViewController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 8/6/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class NutritionalValueViewController: UIViewController, UISearchBarDelegate {

    var indicator = UIActivityIndicatorView()
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var nutritionalValues: UILabel!
    
    override func viewDidLoad() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter food name"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText.count > 0 else {
            return;
        }
        
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        
        let separatedText = searchText.split(separator: " ").joined(separator: "+")
        print(separatedText)
        
        let searchString = "https://api.edamam.com/api/food-database/parser?&ingr=\(separatedText)&app_id=459d6c40&app_key=2d5b6f118c5aa9836cacda90ed8db252"
        
        let url = URL(string: searchString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)
//        let url = URL(string: searchString)
        let nutritionSearch = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
            if let error = error {
                print("X")
                DispatchQueue.main.async {
                    self.displayMessage(title: "Error", msg: error.localizedDescription)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let foodData = try decoder.decode(FoodData.self, from: data!)
                if let nutrientsArray = foodData.nutrients {
                    let nutrients = nutrientsArray[0]
                    var nutrientsText = ""
                    if let calcium = nutrients.calcium {
                        nutrientsText += "Calcium: \(calcium)\n"
                    }
                    if let calories = nutrients.calories {
                        nutrientsText += "Calories: \(calories)\n"
                    }
                    if let carbs = nutrients.carbs {
                        nutrientsText += "Carbs: \(carbs)\n"
                    }
                    if let cholesterol = nutrients.cholesterol {
                        nutrientsText += "Cholesterol: \(cholesterol)\n"
                    }
                    if let fat = nutrients.fat {
                        nutrientsText += "Fats: \(fat)\n"
                    }
                    if let fiber = nutrients.fiber {
                        nutrientsText += "Fiber: \(fiber)\n"
                    }
                    if let protein = nutrients.protein {
                        nutrientsText += "Protein: \(protein)\n"
                    }
                    if let sugar = nutrients.sugar {
                        nutrientsText += "Sugar: \(sugar)\n"
                    }
                    
                    DispatchQueue.main.async {
                        self.itemLabel.text = foodData.title
                        self.nutritionalValues.text = nutrientsText
                    }
                }
            } catch let err {
                DispatchQueue.main.async {
                    print("C")
                    self.displayMessage(title: "Error", msg: err.localizedDescription)
                }
            }
        }
        nutritionSearch.resume()
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
