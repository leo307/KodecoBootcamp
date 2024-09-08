//
//  PexelsResponse.swift
//  week9
//
//  Created by Leo DelPrete on 6/16/24.
//

import Foundation

struct PexelsResponse: Codable {
    let totalResults: Int
    let page: Int
    let perPage: Int
    let photos: [PexelImage]

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page
        case perPage = "per_page"
        case photos
    }
}
