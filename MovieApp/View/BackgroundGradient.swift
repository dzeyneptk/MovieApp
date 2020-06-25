//
//  BackgroundGradient.swift
//  MovieApp
//
//  Created by Zeynebim on 25.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
import UIKit
struct Gradient {
    static let shared = Gradient()
    
    func addGradientToView(view: UIView) {
        //gradient layer
        let gradientLayer = CAGradientLayer()
        
        //define colors
        gradientLayer.colors = [
            UIColor(red:0.00, green:0.55, blue:0.53, alpha:1.0), UIColor(red: 0.32, green: 0.22, blue: 0.0, alpha: 1.0)]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
