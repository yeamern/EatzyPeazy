//
//  RsByIngredientsTableViewController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 27/5/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class RsByIngredientsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let RECIPE_CELL = "recipeCell"
    var indicator = UIActivityIndicatorView()
    var newRecipes = [RecipeData]()
    var selectedRecipe: RecipeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "eg. apple,flour,sugar.."
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.tableView.center
        self.view.addSubview(indicator)
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText.count > 0 else {
            return;
        }
        
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        
        let separatedText = searchText.split(separator: ",").joined(separator: "%2C")
        
        let searchString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?number=5&ranking=1&ignorePantry=false&ingredients=\(separatedText)"
        
        let url = URL(string: searchString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)
        var request = URLRequest(url:url!)
        request.setValue("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue("e9a2e55382mshb4dae899b514712p102d18jsn1b4d6941ccb3", forHTTPHeaderField: "X-RapidAPI-Key")
        let recipe = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
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
                    print("y")
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = newRecipes[indexPath.row]
        self.selectedRecipe = recipe
        performSegue(withIdentifier: "ingredientsSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
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
        if segue.identifier == "ingredientsSegue" {
            let dest = segue.destination as! RecipeTableViewController
            dest.selectedRecipe = self.selectedRecipe
        }
    }
}
