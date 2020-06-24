//
//  ResponseModel.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation

struct ResponseModel : Codable {
    let title : String?
    let year : String?
    let rated : String?
    let released : String?
    let runtime : String?
    let genre : String?
    let director : String?
    let writer : String?
    let actors : String?
    let plot : String?
    let language : String?
    let country : String?
    let awards : String?
    let poster : String?
    let ratings : [Ratings]?
    let metascore : String?
    let imdbRating : String?
    let imdbVotes : String?
    let imdbID : String?
    let type : String?
    let totalSeasons : String?
    let response : String?

    enum CodingKeys: String, CodingKey {

        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbID = "imdbID"
        case type = "Type"
        case totalSeasons = "totalSeasons"
        case response = "Response"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        rated = try values.decodeIfPresent(String.self, forKey: .rated)
        released = try values.decodeIfPresent(String.self, forKey: .released)
        runtime = try values.decodeIfPresent(String.self, forKey: .runtime)
        genre = try values.decodeIfPresent(String.self, forKey: .genre)
        director = try values.decodeIfPresent(String.self, forKey: .director)
        writer = try values.decodeIfPresent(String.self, forKey: .writer)
        actors = try values.decodeIfPresent(String.self, forKey: .actors)
        plot = try values.decodeIfPresent(String.self, forKey: .plot)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        awards = try values.decodeIfPresent(String.self, forKey: .awards)
        poster = try values.decodeIfPresent(String.self, forKey: .poster)
        ratings = try values.decodeIfPresent([Ratings].self, forKey: .ratings)
        metascore = try values.decodeIfPresent(String.self, forKey: .metascore)
        imdbRating = try values.decodeIfPresent(String.self, forKey: .imdbRating)
        imdbVotes = try values.decodeIfPresent(String.self, forKey: .imdbVotes)
        imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        totalSeasons = try values.decodeIfPresent(String.self, forKey: .totalSeasons)
        response = try values.decodeIfPresent(String.self, forKey: .response)
    }

}
