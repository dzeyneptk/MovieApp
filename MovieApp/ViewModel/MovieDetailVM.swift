//
//  MovieVM.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
import AlamofireImage

class MovieDetailVM {
    private var responseModel: ResponseModel?
    private var result: String = ""
    private var imageResult: UIImage? = nil
    weak var delegate: MovieDetailDelegate?
    weak var posterDelegate: PosterImageDelegate?
    
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
    
    // MARK: - Image Fetch Service
    func getImage(url: String) {
        NetworkManager.shared.fetchImage(imageUrl: url)  { (image, error) in
        if let error = error {
            self.posterDelegate?.failWith(error: error.localizedDescription)
            return
        }
            if let image = image {
                self.imageResult = image
                self.posterDelegate?.succes()
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
    var image: UIImage? {
        return imageResult
    }
}

protocol MovieDetailDelegate: class {
    func failWith(error: String?)
    func succes()
}
protocol PosterImageDelegate: class {
    func failWith(error: String?)
    func succes()
}

