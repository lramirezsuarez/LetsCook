//
//  ImageView+Download.swift
//  HackerRankTest
//
//  Created by Luis Alejandro Ramirez on 12/20/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(url: String?) {
        guard let urlString = url, let validUrl = URL(string: urlString) else {
            self.image = UIImage()
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: validUrl) else {
                self.image = UIImage()
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
