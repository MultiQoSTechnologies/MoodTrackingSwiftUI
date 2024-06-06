//
//  Collection+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation


extension Collection {
    
    func toData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
    
    func toJson(shouldPrettyPrinted: Bool = true) -> String {
        do {
            var options:JSONSerialization.WritingOptions = []
            if shouldPrettyPrinted {
                options = [.prettyPrinted]
            }
            
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
                print("Can't create string with data.")
                return "{}"
            }
            return jsonString
        } catch let parseError {
            print("json serialization error: \(parseError)")
            return "{}"
        }
    }
}


extension Dictionary {
   func castToObject<T: Decodable>() -> T? {
       let json = try? JSONSerialization.data(withJSONObject: self)
       return json == nil ? nil : try? JSONDecoder().decode(T.self, from: json!)
   }
}
