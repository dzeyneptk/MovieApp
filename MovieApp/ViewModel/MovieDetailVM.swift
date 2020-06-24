//
//  MovieVM.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
protocol MovieDetailDelegate: class {
    func failWith(error: String?)
    func succes()
}

class MovieDetailVM {
    private var responseModel: ResponseModel?
    private var result: String = ""
    weak var delegate: MovieDetailDelegate?
    
    // MARK: - OMDbAPIService
    func getMovieName(by text: String) {
        
        let requestParameter = RequestModel(movieName: text)
        NetworkManager.shared.fetchService(request: requestParameter) { (response, error) in
            if let error = error {
                self.delegate?.failWith(error: error.localizedDescription)
                return
            }
            if let response = response {
                self.responseModel = response
                self.result = response.title ?? ""
                self.delegate?.succes()
            }
        }
    }
    
    var imdbRating: String? {
        return ResponseVM(model: responseModel).imdbRating
    }
    
    var actors: String? {
        return ResponseVM(model: responseModel).actors
    }
    
    var country: String? {
        return ResponseVM(model: responseModel).country
    }
    var placeCount: Int? {
        return 1
    }
    var getString: String? {
        return result
    }
}
