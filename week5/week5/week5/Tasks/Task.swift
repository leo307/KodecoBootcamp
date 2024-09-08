//
//  Task.swift
//  week5
//
//  Created by Leo DelPrete on 5/18/24.
//

import SwiftUI

struct Task : Hashable, Identifiable {
    
    let id: UUID
    var title: String
    var notes: String
    var isCompleted: Bool
    
}
