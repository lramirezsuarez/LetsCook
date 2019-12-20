//
//  DataRequest.swift
//  HackerRankTest
//
//  Created by Luis Alejandro Ramirez on 12/20/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation

struct DataRequest {
    static func loadRecipes(completion: @escaping (([Recipe]) -> Void)) {
        loadRecipesFromNetwork { recipes in
            guard let networkRecipes = recipes else {
                let recipes = [Recipe()]
                completion(recipes)
                return
            }
            completion(networkRecipes)
        }
    }
    
    static func loadRecipe(withId id: Int, completion: @escaping ((RecipeDetail) -> Void)) {
        loadRecipeFromNetwork(withId: id) { recipeDetail in
            guard let recipeDetail = recipeDetail else {
                completion(RecipeDetail())
                return
            }
            completion(recipeDetail)
        }
    }
    
    static private func loadRecipesFromNetwork(completion: @escaping (([Recipe]?) -> Void)) {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "gl-endpoint.herokuapp.com"
        components.path = "/recipes"
        let jsonDecoder = JSONDecoder()
        
        guard let url = components.url,
            let timeoutInterval = TimeInterval(exactly: 300) else {
            preconditionFailure("Failed to construct URL")
        }
        let taskConfiguration = URLSessionConfiguration.default
        taskConfiguration.timeoutIntervalForRequest = timeoutInterval
        
        let urlSession = URLSession(configuration: taskConfiguration)
        let task = urlSession.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    let recipesDecoded = try? jsonDecoder.decode([Recipe].self, from: data)
                    completion(recipesDecoded)
                } else {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    static private func loadRecipeFromNetwork(withId id: Int, completion: @escaping ((RecipeDetail?) -> Void)) {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "gl-endpoint.herokuapp.com"
        components.path = "/recipes/\(id)"
        let jsonDecoder = JSONDecoder()
        
        guard let url = components.url,
            let timeoutInterval = TimeInterval(exactly: 300) else {
            preconditionFailure("Failed to construct URL")
        }
        let taskConfiguration = URLSessionConfiguration.default
        taskConfiguration.timeoutIntervalForRequest = timeoutInterval
        
        let urlSession = URLSession(configuration: taskConfiguration)
        let task = urlSession.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    let recipeDecoded = try? jsonDecoder.decode(RecipeDetail.self, from: data)
                    completion(recipeDecoded)
                } else {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}
