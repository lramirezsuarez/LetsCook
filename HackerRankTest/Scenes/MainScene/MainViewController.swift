//
//  MainViewController.swift
//  HackerRankTest
//
//  Created by Luis Alejandro Ramirez on 12/20/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var recipesSearchBar: UISearchBar!
    @IBOutlet weak var recipesTableView: UITableView!
    
    var recipes: [Recipe]?
    var originalRecipes: [Recipe]?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecipes()
    }

    private func loadRecipes() {
        DataRequest.loadRecipes { recipes in
            self.recipes = recipes
            self.recipesTableView.reloadData()
        }
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipe = recipes?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = recipe.title
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = recipes?[indexPath.row],
            let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "\(DetailViewController.self)") as? DetailViewController else {
            print("Selected the wrong recipe")
            return
        }
        detailViewController.recipeId = recipe.id
        present(detailViewController, animated: true, completion: nil)
//        print("Selected the recipe \(recipe.id ?? 0) called \(recipe.title ?? "Nil title")")
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        originalRecipes = recipes
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            recipes = originalRecipes
            recipesTableView.reloadData()
            return
        }
        recipes = originalRecipes?.filter( { ($0.title?.contains(searchText) ?? false) })
        recipesTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
