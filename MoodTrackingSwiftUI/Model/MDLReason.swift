//
//  MDLReason.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 06/06/24.
//

import Foundation

class MDLReason: Identifiable, Codable, Equatable {
    static func == (lhs: MDLReason, rhs: MDLReason) -> Bool {
        lhs.id == rhs.id
    } 
    
    var id = UUID().uuidString
    var reason: String
    var selected = false
    
    init(reason: String) {
        self.reason = reason
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.reason = try container.decode(String.self, forKey: .reason)
    }
}
