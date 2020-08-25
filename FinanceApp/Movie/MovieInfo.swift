//
//  PostInfo.swift
//  MyMovieApp
//
//  Created by Sheryl Evangelene Pulikandala on 8/14/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import Foundation

struct MovieResults: Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
     var results : [MovieInfo]
}

struct MovieInfo: Codable {
    var popularity: Float
    var vote_count: Int
    var poster_path: String
    var id: Int
    var title: String
    var overview: String
    var original_language: String
    var vote_average: Float
    var release_date: String
    
}

