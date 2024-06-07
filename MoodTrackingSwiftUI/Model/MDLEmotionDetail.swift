//
//  MDLEmotionDetaits.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 06/06/24.
//

import Foundation

class MDLEmotionDetail: Identifiable, Codable, Equatable {
    
    static func == (lhs: MDLEmotionDetail, rhs: MDLEmotionDetail) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String?
    var moods: [MDLMood]?
    var reasons: [MDLReason]?
    var createdAt: Double?
    var onmind: String?
    var tip: String?
    var tipHeader: String?
    var moodHeader: String?
    var expanded = false
    var expandedTip = false
    
    init(moods: [MDLMood]? = nil, reasons: [MDLReason]? = nil, createdAt: Double? = nil, onmind: String? = nil, tip: String? = nil, tipHeader: String? = nil, id: String? = nil, moodHeader: String? = nil) {
        self.moods = moods
        self.reasons = reasons
        self.createdAt = createdAt
        self.onmind = onmind
        self.tip = tip
        self.tipHeader = tipHeader
        self.id = id
        self.moodHeader = moodHeader
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.moods = try container.decodeIfPresent([MDLMood].self, forKey: .moods)
        self.reasons = try container.decodeIfPresent([MDLReason].self, forKey: .reasons)
        self.createdAt = try container.decodeIfPresent(Double.self, forKey: .createdAt)
        self.onmind = try container.decodeIfPresent(String.self, forKey: .onmind)
        self.tip = try container.decodeIfPresent(String.self, forKey: .tip)
        self.tipHeader = try container.decodeIfPresent(String.self, forKey: .tipHeader)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.moodHeader = try container.decodeIfPresent(String.self, forKey: .moodHeader)
    }
}
