//
//  ExtensionInt.swift
//  Swifty_Master
//
//  Created by Mac-0002 on 01/09/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension of Int For Converting it TO String.
extension Int {
    
    /// A Computed Property (only getter) of String For getting the String value from Int.
    var toString:String {
        return "\(self)"
    }
    
    var toDouble:Double {
        return Double(self)
    }
    
    var toFloat:Float {
        return Float(self)
    }
    
    var toCGFloat:CGFloat {
        return CGFloat(self)
    }
    
    var aspectRatio: CGFloat {
        return UIDevice.screenWidth * (self.toCGFloat / UIDevice.width)
    }
    
}

extension Int {
    
    var formatPoints: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        } else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        } else if billion >= 1.0 {
            return ("\(round(billion*10/10))B")
        } else {
            return "\(Int(number))"
        }
    }
}
