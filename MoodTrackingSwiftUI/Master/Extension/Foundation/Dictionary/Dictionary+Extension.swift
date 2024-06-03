//
//  Dictionary+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation

extension Dictionary {
    func toURLQuery(baseURL: String) -> URL {
        
        guard let dict = self as? [String: Any],
            let url = URL(string: baseURL),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                fatalError("Invalid URL/Parameters")
        }
        let queryItems = dict.compactMap({ URLQueryItem(name: $0, value: "\($1)") })
        components.queryItems = queryItems
        guard let finalURL = components.url else {
            fatalError("Invalid URL")
        }
        return finalURL
    }
}
