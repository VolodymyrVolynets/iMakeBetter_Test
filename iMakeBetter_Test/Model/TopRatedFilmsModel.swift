//
//  TopRatedFilmsModel.swift
//  iMakeBetter_Test
//
//  Created by Vova on 15/11/2023.

import Foundation

struct TopRatedFilmsModel: Codable {
    let page: Int
    let results: [FilmModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
