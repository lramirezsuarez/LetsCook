//
//  MockDataRequest.swift
//  HackerRankTestTests
//
//  Created by Luis Alejandro Ramirez on 12/20/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation
@testable import HackerRankTest

struct MockDataRequest: DataRequestProtocol {
    static func loadRecipes(completion: @escaping (([Recipe]) -> Void)) {
        let recipe1 = Recipe(id: 1, title: "Test Recipe")
        let recipe2 = Recipe(id: 2, title: "Test Recipe 2")
        let recipe3 = Recipe(id: 3, title: "Test Recipe 3")
        completion([recipe1, recipe2, recipe3])
    }
    
    static func loadRecipe(withId id: Int, completion: @escaping ((RecipeDetail) -> Void)) {
        let recipeDetail1 = RecipeDetail(id: 1, title: "Test Recipe", rating: 5, image: "http://www.google.com/", instructions: "These are the instructions of the recipe.")
        completion(recipeDetail1)
    }
    
}

struct MockedRecipe {
    static let recipes = [Recipe(id: 1, title: "Test Recipe"), Recipe(id: 2, title: "Test Recipe 2"), Recipe(id: 3, title: "Test Recipe 3")]
    
    static let recipeDetail1 = RecipeDetail(id: 1, title: "Test Recipe", rating: 5, image: "http://www.google.com/", instructions: "These are the instructions of the recipe.")
}
