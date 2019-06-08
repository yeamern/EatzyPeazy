//
//  RecipeTableViewController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 8/6/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    var selectedRecipe: RecipeData?
    var image: URL?
    var recipeTitle: String?
    var readyInMinutes: Int?
    var instructions: String?
    var extendedIngredients: [IngredientsData]?
    var calories: String?
    var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedRecipe?.title

        let searchString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(selectedRecipe!.id!)/information"
        
        let url = URL(string: searchString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)
        var request = URLRequest(url:url!)
        request.setValue("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue("e9a2e55382mshb4dae899b514712p102d18jsn1b4d6941ccb3", forHTTPHeaderField: "X-RapidAPI-Key")
        
        let recipe = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error {
                self.displayMessage(title: "Error", msg: error.localizedDescription)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipeData = try decoder.decode(GetRecipeData.self, from: data!)
                self.image = recipeData.image
                self.recipeTitle = recipeData.title
                self.readyInMinutes = recipeData.readyInMinutes
                self.instructions = recipeData.instructions
                self.extendedIngredients = recipeData.extendedIngredients
                self.loaded = true
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let err {
                DispatchQueue.main.async {
                    self.displayMessage(title: "Error", msg: err.localizedDescription)
                }
            }
        }
        recipe.resume()
        
        // Calories request
        let caloriesSearchString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(selectedRecipe!.id!)/nutritionWidget.json"
        
        let caloriesUrl = URL(string: caloriesSearchString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)
        var caloriesRequest = URLRequest(url:caloriesUrl!)
        caloriesRequest.setValue("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        caloriesRequest.setValue("e9a2e55382mshb4dae899b514712p102d18jsn1b4d6941ccb3", forHTTPHeaderField: "X-RapidAPI-Key")
        
        let calories = URLSession.shared.dataTask(with: caloriesRequest) {
            (data, response, error) in
            
            if let error = error {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let caloriesData = try decoder.decode(CaloriesData.self, from: data!)
                self.calories = caloriesData.calories
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let err {
                DispatchQueue.main.async {
                    self.displayMessage(title: "Error", msg: err.localizedDescription)
                }
            }
        }
        calories.resume()
    }


    func displayMessage(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: // image and calories
            return loaded ? (self.calories != nil ? 2 : 1) : 0
        case 1: // ready in minutes
            return loaded ? 1 : 0
        case 2:
            return loaded ? self.extendedIngredients!.count : 0
        case 3:
            return loaded ? 1 : 0
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! RecipeImageTableViewCell
                let imageDownload = URLSession.shared.dataTask(with: self.image!) { (data, response, error) in
                    
                    if let error = error {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        cell.recipeImageView.image = UIImage(data: data!)
                    }
                }
                imageDownload.resume()
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! RecipeTextTableViewCell
                cell.recipeLabel.text = "Calories: \(String(self.calories!))"
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! RecipeTextTableViewCell
            cell.recipeLabel.text = "Preparation time: \(String(self.readyInMinutes!)) minutes"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! RecipeTextTableViewCell
            cell.recipeLabel.text = extendedIngredients![indexPath.row].originalString
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! RecipeTextTableViewCell
            cell.recipeLabel.text = self.instructions
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
