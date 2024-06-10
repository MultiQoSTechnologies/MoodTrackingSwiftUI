//
//  Optional+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    
    func isEmptyOrNil() -> Bool {
        guard let strongSelf = self else {
            return true
        }
        return strongSelf.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? true : false
    }
}
