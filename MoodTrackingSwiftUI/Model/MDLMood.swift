//
//  MDLMood.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 05/06/24.
//

import Foundation

class MDLMood: Codable, Equatable, Identifiable {
    static func == (lhs: MDLMood, rhs: MDLMood) -> Bool {
        lhs.mood == rhs.mood
    } 
    
    var id = UUID().uuidString
    var mood: String?
    var img: String?
    var selected = false
    
    init(mood: String?, img: String?) {
        self.img = img
        self.mood = mood
    }
    
     required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mood = try container.decode(String.self, forKey: .mood)
        self.img = try container.decode(String.self, forKey: .img)
    }
}
