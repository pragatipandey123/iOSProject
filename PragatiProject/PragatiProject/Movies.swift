//
//  Movies.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 25/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import Foundation

struct Movie: Codable {
 var page : Int?
 var results : [MovieData]
 var totalPages : Int?
 var totaResults : Int?
 }
struct MovieData: Codable {
 var id: Int?
 var video: Bool?
 var vote_count: Int?
 var vote_average: Float?
 var title: String?
 var release_date: String?
 var original_language: String?
 var original_title: String?
 var backdrop_path: String?
 var adult: Bool?
 var overview: String?
 var poster_path: String?
 var popularity: Float?
 var media_type: String?
 var name: String?
 var first_air_date: String?
}

//struct BestDrama: Codable {
//    var page: Int?
//    var results: [BestDramaData]?
//    var total_pages: Int?
//    var total_results: Int?
//}
//struct BestDramaData: Codable {
//     var backdrop_path: String?
//     var poster_path: String?
//     var title: String?
//     var vote_average: Double?
//}
//
//struct PopularityData: Codable {
//    var page: Int?
//    var results: [Popularity]?
//    var total_pages: Int?
//    var total_results: Int?
//}
//struct Popularity: Codable {
//    var backdrop_path: String?
//     var poster_path: String?
//     var title: String?
//     var vote_average: Double?
//}
//
//struct ScienceFictionData: Codable {
//    var page: Int?
//    var results: [ScienceFiction]?
//    var total_pages: Int?
//    var total_results: Int?
//}
//struct ScienceFiction: Codable {
//    var backdrop_path: String?
//     var poster_path: String?
//     var title: String?
//     var vote_average: Double?
//}
//struct KidsData: Codable {
//    var page: Int?
//    var results: [Kids]?
//    var total_pages: Int?
//    var total_results: Int?
//}
//struct Kids: Codable {
//    var backdrop_path: String?
//     var poster_path: String?
//     var title: String?
//     var vote_average: Double?
//}

struct OtherMovies: Codable
{
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [Details]?
}

struct Details: Codable
{
    var popularity: Float?
    var vote_count: Int?
    var video: Bool?
    var vote_average: Float?
    var title: String?
    var release_date: String?
    var original_language: String?
    var original_title: String?
    var backdrop_path: String?
    var adult: Bool?
    var poster_path: String?
    var id: Int?
    var overview: String?
}
