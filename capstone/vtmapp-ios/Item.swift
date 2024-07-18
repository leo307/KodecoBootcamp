//
//  Item.swift
//  vtmapp-ios
//
//  Created by Mark Stralka on 7/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
