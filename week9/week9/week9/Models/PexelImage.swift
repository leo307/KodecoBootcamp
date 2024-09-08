//
//  PexelImage.swift
//  week9
//
//  Created by Leo DelPrete on 6/16/24.
//

import Foundation

struct PexelImage: Codable {
    let id: Int
    let url: String
    let photographer: String
    let src: SRC
    
    struct SRC: Codable {
        let large: String
        let large2x: String
    }
}
