//
//  ResponseVM.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation

struct ResponseVM {
    private var responseModel : ResponseModel?
    
    init(model: ResponseModel?) {
        self.responseModel = model
    }
    
    var title : String? {
        return responseModel?.title ?? ""
    }
    var year : String? {
        return responseModel?.year ?? ""
    }
    var rated : String? {
        return responseModel?.rated ?? ""
    }
    var released : String? {
        return responseModel?.released ?? ""
    }
    var runtime : String? {
        return responseModel?.runtime ?? ""
    }
    var genre : String? {
        return responseModel?.genre ?? ""
    }
    var director : String? {
        return responseModel?.director ?? ""
    }
    var writer : String? {
        return responseModel?.writer ?? ""
    }
    var actors : String? {
     return responseModel?.actors ?? ""
    }
    var plot : String? {
        return responseModel?.plot ?? ""
    }
    var language : String? {
        return responseModel?.language ?? ""
    }
    var country : String? {
        return responseModel?.country ?? ""
    }
    var awards : String? {
        return responseModel?.awards ?? ""
    }
    var poster : String? {
        return responseModel?.poster ?? ""
    }
    var metascore : String? {
        return responseModel?.metascore ?? ""
    }
    var imdbRating : String? {
        return responseModel?.imdbRating ?? ""
    }
    var imdbVotes : String? {
        return responseModel?.imdbVotes ?? ""
    }
    var imdbID : String? {
        return responseModel?.imdbID ?? ""
    }
    var type : String? {
        return responseModel?.type ?? ""
    }
    var totalSeasons : String? {
        return responseModel?.totalSeasons ?? ""
    }
    var response : String? {
        return responseModel?.response ?? ""
    }
    var ratings : RatingsVM? {
        guard let response = responseModel else { return nil }
        return RatingsVM(model: response.ratings?[0])
    }
}

struct RatingsVM {
    private var responseModel: Ratings?
    init(model: Ratings?) {
        self.responseModel = model
    }
    
    var source: String {
        return responseModel?.source ?? ""
    }
    var value: String {
        return responseModel?.value ?? ""
    }
}
