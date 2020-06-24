//
//  RequestModel.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
struct RequestModel: Codable {
    var t: String
    var apikey: String
    
    init(movieName: String) {
        self.t = movieName
        self.apikey = AppConstant.apikey
    }
}
