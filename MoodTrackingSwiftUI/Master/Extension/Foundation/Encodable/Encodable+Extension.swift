//
//  Encodable+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation

extension Encodable where Self: Decodable {
    
    init(from: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        self = try JSONDecoder().decode(Self.self, from: data)
    }
    
    var jsonObject: String {
        guard let data = try? self.encoded(), let objJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return "" }
        if let dict = objJSON as? [String: Any] {
            return dict.toJson()
        } else if let arr = objJSON as? [[String: Any]] {
            return arr.toJson()
        }
        return ""
    }
    
    var objectSize: String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }
        return data.formattedLength
    }
    
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
