//
//  MovieVM.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
import Firebase

protocol MovieDetailDelegate: class {
    func failWith(error: String?)
    func succes()
}

class MovieDetailVM {
    private var responseModel: ResponseModel?
    private var result: [String] = []
    private var imageResult: UIImage? = nil
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
                self.prepareData()
                self.delegate?.succes()
            }
        }
    }
    
    // MARK: - Image Fetch Service
    func getImage(url: String) {
        NetworkManager.shared.fetchImage(imageUrl: url)  { (image, error) in
        if let error = error {
            self.delegate?.failWith(error: error.localizedDescription)
            return
        }
            if let image = image {
                self.imageResult = image
                self.delegate?.succes()
            }
        }
    }
    
    var getString: String {
        return responseModel?.title ?? "Movie not found!"
    }
    var poster: String? {
        return ResponseVM(model: responseModel).poster
    }
    var image: UIImage? {
        return imageResult
    }
    
    var dataCount: Int {
        return result.count
    }
    func getData(atIndex: Int) -> String {
        return result[atIndex]
    }
    
    private func prepareData() {
        result.removeAll()
        result.append("Movie Name: " + (responseModel?.title ?? "") )
        result.append("Imdb: " + (responseModel?.imdbRating ?? "") )
        result.append("Realise time: " + (responseModel?.released ?? ""))
        result.append("Plot:" + (responseModel?.plot ?? ""))
        result.append("Actors: " + (responseModel?.actors ?? "") )
        result.append("Country: " + (responseModel?.country ?? "") )
    }
    
    func sendAnalytics() {
        Analytics.logEvent("movie_details", parameters: [
            "name":  responseModel?.title ?? "" as NSObject,
            "imdbrating": responseModel?.imdbRating ?? "" as NSObject,
            "actors": responseModel?.actors ?? "" as NSObject,
            "country": responseModel?.country ?? "" as NSObject,
        ])
    }
}

