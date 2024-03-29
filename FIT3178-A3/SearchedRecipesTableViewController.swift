//
//  SearchedRecipesTableViewController.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 19/06/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class SearchedRecipesTableViewController: UITableViewController {
    
    var ingredients: [Expiry]?
    
    let RECIPE_CELL = "itemCell"
    var newRecipes = [RecipeData]()
    var selectedRecipe: RecipeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var names = [String]()
        
        for items in ingredients! {
            names.append(items.name!)
        }
        
        let separatedText = names.joined(separator: "%2C")
        
        let searchString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?number=5&ranking=1&ignorePantry=false&ingredients=\(separatedText)"
        
        let url = URL(string: searchString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)
        var request = URLRequest(url:url!)
        request.setValue("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue("e9a2e55382mshb4dae899b514712p102d18jsn1b4d6941ccb3", forHTTPHeaderField: "X-RapidAPI-Key")
        let recipe = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.displayMessage(title: "Error", msg: error.localizedDescription)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipes = try decoder.decode([RecipeData].self, from: data!)
                self.newRecipes = recipes
                
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
    }
    
    func displayMessage(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = newRecipes[indexPath.row]
        self.selectedRecipe = recipe
        performSegue(withIdentifier: "availableSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = newRecipes[indexPath.row].title
        
        return cell
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "availableSegue" {
            let dest = segue.destination as! RecipeTableViewController
            dest.selectedRecipe = self.selectedRecipe
        }
    }
}
