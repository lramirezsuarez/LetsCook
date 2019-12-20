//
//  DataRequestTests.swift
//  HackerRankTestTests
//
//  Created by Luis Alejandro Ramirez on 12/20/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import XCTest
@testable import HackerRankTest

class DataRequestTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testLoadRecipes() {
        var recipes: [Recipe] = []
        MockDataRequest.loadRecipes { receivedRecipes in
            recipes = receivedRecipes
        }
        XCTAssert(recipes.count == MockedRecipe.recipes.count, "The amount of recipes is different, test failed.")
    }
    
    func testLoadRecipe() {
        var recipe: RecipeDetail = RecipeDetail()
        MockDataRequest.loadRecipe(withId: 1) { receivedRecipe in
            recipe = receivedRecipe
        }
        
        XCTAssert(recipe.id == MockedRecipe.recipeDetail1.id, "Received the wrong or invalid recipe, test failed.")
    }

}
