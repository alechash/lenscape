//
//  Item.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/8/24.
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
