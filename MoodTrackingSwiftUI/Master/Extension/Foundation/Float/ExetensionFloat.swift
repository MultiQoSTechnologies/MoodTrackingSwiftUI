//
//  ExetensionFloat.swift
//  Swifty_Master
//
//  Created by Mac-0002 on 10/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import UIKit

extension Float {
    
    var toInt:Int? {
        return Int(self)
    }
    
    var toDouble:Double? {
        return Double(self)
    }
    
    var toString:String {
        return "\(self)"
    }
    
    var toCGFloat:CGFloat {
        return CGFloat(self)
    }
    
    var aspectRatio: CGFloat {
        return UIDevice.screenWidth * (self.toCGFloat / UIDevice.width)
    }
}
