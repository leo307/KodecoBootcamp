//
//  University.swift
//  week8
//
//  Created by Leo DelPrete on 6/9/24.
//

import Foundation

struct University: Identifiable, Decodable {
    
    var id: String { name }
    let name: String
    let country: String
    let web_pages: [String]
}
