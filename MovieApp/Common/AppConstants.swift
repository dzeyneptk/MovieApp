//
//  AppConstants.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation

struct AppConstant {
//    static let endPoint = "https://maps.googleapis.com/maps/api/geocode/json"
    
    enum segueIdentifier: String {
        case splashToMain = "fromSplashToMain"
        
        var description: String {
            return self.rawValue
        }
    }
}
