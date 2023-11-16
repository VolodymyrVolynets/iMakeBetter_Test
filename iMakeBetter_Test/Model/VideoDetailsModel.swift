//
//  VideoDetailsModel.swift
//  iMakeBetter_Test
//
//  Created by Vova on 16/11/2023.
//

import Foundation

struct VideoDetailsModel: Codable {
    let name, key: String

    enum CodingKeys: String, CodingKey {
        case name, key
    }
}
