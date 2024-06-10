//
//  URL+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    
    func canOpen() -> Bool {
        return UIApplication.shared.canOpenURL(self)
    }
    
    func open() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(self, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(self)
        }
    }
}

extension URL {
    
    enum FileExtension: String {
        case jpg = "jpg"
        case jpeg = "jpeg"
        case png = "png"
        case gif = "gif"
        case heic = "heic"
        case unsupported
    }
    
    func getFileExtension() -> FileExtension {
        
        let lowercasedAbsoluteString = self.absoluteString.lowercased()
        if lowercasedAbsoluteString.hasSuffix("jpg") {
            return .jpg
        } else if lowercasedAbsoluteString.hasSuffix("jpeg") {
            return .jpeg
        } else if lowercasedAbsoluteString.hasSuffix("png") {
            return .png
        } else if lowercasedAbsoluteString.hasSuffix("gif") {
            return .gif
        } else if lowercasedAbsoluteString.hasSuffix("heic") {
            return .heic
        } else {
            return .unsupported
        }
    }
    
}

extension URL {
    
    /// A Computed Property (only getter) of URL For getting the String value from URL.
    /// This Computed Property (only getter) returns String? , it means this Computed Property (only getter) return nil value also , while using this Computed Property (only getter) please use if let. If you are not using if let and if this Computed Property (only getter) returns nil and when you are trying to unwrapped this value("String!") then application will crash.
    var toString: String? {
        return self.absoluteString
    }
    
    var toData: Data? {
        do {
            let data = try Data(contentsOf: self)
            return data
        } catch {
            return nil
        }
    }
}

