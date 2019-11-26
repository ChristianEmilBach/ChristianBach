//
//  GradientViewExtension.swift
//  ChristianBach
//
//  Created by Christian Emil Bach on 23/11/2019.
//  Copyright © 2019 Christian Emil Bach. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
        
    
}
