//
//  MDLEmotionDetaits.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 06/06/24.
//

import Foundation

class MDLEmotionDetail: Identifiable, Codable {
    
    var moods: [MDLMood]?
    var reasons: [MDLReason]?
    var createdAt: Double?
    var onmind: String?
    var tip: String?
    var expanded = false
    
    init(moods: [MDLMood]? = nil, reasons: [MDLReason]? = nil, createdAt: Double? = nil, onmind: String? = nil, tip: String? = nil) {
        self.moods = moods
        self.reasons = reasons
        self.createdAt = createdAt
        self.onmind = onmind
        self.tip = tip
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.moods = try container.decodeIfPresent([MDLMood].self, forKey: .moods)
        self.reasons = try container.decodeIfPresent([MDLReason].self, forKey: .reasons)
        self.createdAt = try container.decodeIfPresent(Double.self, forKey: .createdAt)
        self.onmind = try container.decodeIfPresent(String.self, forKey: .onmind)
        self.tip = try container.decodeIfPresent(String.self, forKey: .tip)
    }
}
