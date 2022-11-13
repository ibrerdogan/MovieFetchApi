//
//  UpComingMovieModel.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//


import Foundation


struct UpComingMovieModel: Codable {
    let dates: Dates
    let page: Int
    let results: [MovieBaseModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


