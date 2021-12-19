//
//  MoviesListModels.swift
//  Movies
//
//  Created by Mujahid Ali on 17/12/21.
//

import Foundation
struct MoviesListRespoonse: Codable {
    var results: [MoviesList]?
}
struct MoviesList: Codable {
    var id: Int?
    var original_title: String?
    var original_language: String?
    var overview: String?
    var release_date: String?
    var title: String?
    var vote_average: Float64?
    var backdrop_path: String?
    var poster_path: String?
    var isSelected: Bool = false
}
