//
//  AppConstants.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
struct AppConstant {
    static let apiUrl = "http://www.omdbapi.com/"
    static let apikey = "7478742a"
    
    enum segueIdentifier: String {
        case splashToSearch = "fromSplashToSearch"
        case searchToDetail = "fromSearchToDetail"
        
        var description: String {
            return self.rawValue
        }
    }
    enum indicatorViewType: String {
        case entryLoad = "lineScalePulseOut"
        case searchingLoad = ""
        
        var description: String {
            return self.rawValue
        }
    }
}
