//
//  MDLUser.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 05/06/24.
//

import Foundation

struct MDLUser: Codable {
    var name: String?
    var phone: String?
    var email: String?
    var uid: String?
    
    
    init(name: String? = nil, phone: String? = nil, email: String? = nil, uid: String? = nil) {
        self.name = name
        self.phone = phone
        self.email = email
        self.uid = uid
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.uid = try container.decodeIfPresent(String.self, forKey: .uid)
    }
}
