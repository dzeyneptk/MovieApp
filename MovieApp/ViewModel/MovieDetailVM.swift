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
        ActivityIndicator.shared.showIndicator()
        NetworkManager.shared.fetchService(request: requestParameter) { (response, error) in
            if let error = error {
                ActivityIndicator.shared.stopIndicator()
                self.delegate?.failWith(error: error.localizedDescription)
                return
            }
            if let response = response {
                ActivityIndicator.shared.stopIndicator()
                self.responseModel = response
                self.result = response.title ?? ""
                self.delegate?.succes()
            }
        }
    }
    
    var imdbRating: String? {
        return ResponseVM(model: responseModel).imdbRating
    }
    var released: String? {
        return ResponseVM(model: responseModel).released
    }
    var actors: String? {
        return ResponseVM(model: responseModel).actors
    }
    var plot: String? {
        return ResponseVM(model: responseModel).plot
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
    var poster: String? {
        return ResponseVM(model: responseModel).poster
    }
}
