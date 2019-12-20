//
//  DetailViewController.swift
//  HackerRankTest
//
//  Created by Luis Alejandro Ramirez on 12/20/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var starsStackView: UIStackView!
    @IBOutlet weak var firstStarImageView: UIImageView!
    @IBOutlet weak var secondStarImageView: UIImageView!
    @IBOutlet weak var thirdStarImageView: UIImageView!
    @IBOutlet weak var fourthStarImageView: UIImageView!
    @IBOutlet weak var fifthStarImageView: UIImageView!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    
    var recipeId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecipeDetails()
    }

    @IBAction func userDidTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func loadRecipeDetails() {
        guard let recipeId = recipeId else {
            return
        }
        DataRequest.loadRecipe(withId: recipeId) { recipeDetail in
            self.configure(recipeDetail: recipeDetail)
        }
    }
    
    private func configure(recipeDetail: RecipeDetail) {
        recipeNameLabel.text = recipeDetail.title
        configureStars(quantity: recipeDetail.rating)
        mainImageView.downloadImage(url: recipeDetail.image)
        recipeDetailTextView.text = recipeDetail.instructions
    }
    
    private func configureStars(quantity: Int?) {
        guard let stars = quantity else {
            return
        }
        firstStarImageView.image = stars > 0 ? UIImage(named: "filledStar") : UIImage(named: "unfilledStar")
        secondStarImageView.image = stars > 1 ? UIImage(named: "filledStar") : UIImage(named: "unfilledStar")
        thirdStarImageView.image = stars > 2 ? UIImage(named: "filledStar") : UIImage(named: "unfilledStar")
        fourthStarImageView.image = stars > 3 ? UIImage(named: "filledStar") : UIImage(named: "unfilledStar")
        fifthStarImageView.image = stars == 5 ? UIImage(named: "filledStar") : UIImage(named: "unfilledStar")
    }
}
