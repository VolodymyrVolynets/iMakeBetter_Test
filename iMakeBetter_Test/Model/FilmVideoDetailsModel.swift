//
//  DetailFilmModel.swift
//  iMakeBetter_Test
//
//  Created by Vova on 16/11/2023.
//

import Foundation

struct FilmVideoDetailsModel: Codable {
    let id: Int
    let results: [VideoDetailsModel]
}

