//
//  Constants.swift
//  Movies
//
//  Created by Mujahid Ali on 17/12/21.
//

import Foundation

class Constants {
    static let BASE_URL: String = "https://api.themoviedb.org/3/"
    static let IMAGE_BASE_URL: String = "https://image.tmdb.org/t/p/original"
    static let MOVIEW_LIST_END_POINTS: String = "movie/upcoming"
    static let API_KEY: String = "33bb58401bd450343af2dda54d38b4f1"
    static let MAIN_STORYBOARD: String = "Main"
    
    class Images {
        static let PLACEHOLDER_IMAGE: String = "placeholder"
        static let RATING_IAMGE: String = "ratingImg"
    }
    class Keys {
        static let API_KEY: String = "api_key"
        static let ID_KEY: String = "id"
        static let ORIGINAL_TITLE_KEY: String = "original_title"
        static let OVERVIEW_KEY: String = "overview"
        static let RELEASE_DATE_KEY: String = "release_date"
        static let VOTE_AVERAGE_KEY: String = "vote_average"
        static let TITLE_KEY: String = "title"
        static let BACKDROP_PATH_KEY: String = "backdrop_path"
        static let POSTER_PATH_KEY: String = "poster_path"
        static let ORIGINAL_LANGUAGE_KEY: String = "original_language"
    }
    class EntityKeys {
        static let MOVIES_ENTITY_KEY: String = "Movies"
    }
    
}
