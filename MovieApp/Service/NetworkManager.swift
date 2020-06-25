//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    var requestMethod: HTTPMethod = .get
    
    func fetchService(request: RequestModel, complationHandler: @escaping (ResponseModel?, Error?) -> Void ) {
        guard let url = URL(string: AppConstant.apiUrl) else {return}
        
        ActivityIndicator.shared.showIndicator()
        Alamofire.request(url, method: requestMethod, parameters: request.convertToDict(), encoding: URLEncoding(destination: .queryString), headers: nil)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let model =  try JSONDecoder().decode(ResponseModel.self, from: data)
                        ActivityIndicator.shared.stopIndicator()
                        complationHandler(model, nil)
                        
                    } catch let error {
                        ActivityIndicator.shared.stopIndicator()
                        complationHandler(nil, error)
                    }
                case .failure(let error):
                    ActivityIndicator.shared.stopIndicator()
                    complationHandler(nil, error)
                }
        }
    }
    
    func fetchImage(imageUrl: String, complationHandler: @escaping (Image?, Error?) -> Void ) {
        ActivityIndicator.shared.showIndicator()
        Alamofire.request(imageUrl)
            .responseImage { response in
                switch response.result {
                case .success(let image):
                    complationHandler(image, nil)
                    ActivityIndicator.shared.stopIndicator()
                case .failure(let error):
                    ActivityIndicator.shared.stopIndicator()
                    complationHandler(nil, error)
                }
        }
    }
}
