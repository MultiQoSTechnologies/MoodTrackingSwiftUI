//
//  ConvertToNumeric.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import CoreGraphics

/*
 ``` Example
 let value = "10"
 print(value.convert() as Int)
 
 let doubleValue: Double = value.convert()
 print(doubleValue)
 
 let floatValue : Float = value.convert()
 print(floatValue)
 */

protocol NumericType : Comparable {
    
    init(_ value:Float)
    init(_ value:Double)
    init(_ value:Int)
    init(_ value:UInt)
    init(_ value:Int8)
    init(_ value:UInt8)
    init(_ value:Int16)
    init(_ value:UInt16)
    init(_ value:Int32)
    init(_ value:UInt32)
    init(_ value:Int64)
    init(_ value:UInt64)
    init(_ value:CGFloat)
    func convert<T:NumericType>() -> T
}

// Implementations of _asOther() – they simply call the given initialisers listed
// in the protocol requirement (it's required for them to be repeated like this,
// as the compiler won't know which initialiser you're referring to otherwise)
extension Float   : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}

extension Double  : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}

extension CGFloat : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension Int     : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension Int8    : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension Int16   : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension Int32   : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension Int64   : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension UInt    : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension UInt8   : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension UInt16  : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension UInt32  : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}
extension UInt64  : NumericType {
    func convert<T:NumericType>() -> T {
        return self.description.convert()
    }
}

extension String {
    
    func convert<T:NumericType>() -> T {
        
        guard let myNumber = NumberFormatter().number(from: self) else {
            return T(0)
        }
        if (T.self) == Float.self || (T.self) == CGFloat.self{
            return T(myNumber.floatValue)
        }
        if (T.self) == Double.self {
            return T(myNumber.doubleValue)
        }
        if (T.self) == Int.self {
            return T(myNumber.intValue)
        }
        if (T.self) == Int8.self {
            return T(myNumber.int8Value)
        }
        if (T.self) == Int16.self {
            return T(myNumber.int16Value)
        }
        if (T.self) == Int32.self {
            return T(myNumber.int32Value)
        }
        if (T.self) == Int64.self {
            return T(myNumber.int64Value)
        }
        if (T.self) == UInt.self {
            return T(myNumber.uintValue)
        }
        if (T.self) == UInt8.self {
            return T(myNumber.uint8Value)
        }
        if (T.self) == UInt16.self {
            return T(myNumber.uint16Value)
        }
        if (T.self) == UInt32.self {
            return T(myNumber.uint32Value)
        }
        if (T.self) == UInt64.self {
            return T(myNumber.uint64Value)
        }
        
        return T(0)
    }
}
