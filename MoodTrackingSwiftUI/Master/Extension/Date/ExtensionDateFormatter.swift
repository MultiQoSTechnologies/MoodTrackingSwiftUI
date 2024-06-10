//
//  ExtensionDateFormatter.swift
//  TheBayaApp
//
//  Created by mac-0005 on 13/09/18.
//  Copyright © 2018 mac-0005. All rights reserved.
//

import UIKit

// MARK:- Date Related Functions
// MARK:-

let kHHmm = "HH:mm"
let kddMMMYYYhhmm = "dd MMM YYYY, HH:mm"
let kMMddYYYY = "MM/dd/YYYY"


//MARK:-
//MARK:- Extension - DateFormatter Singleton
extension DateFormatter {
    private static var sharedInstance: DateFormatter = {
        let dateFormatter = DateFormatter()
       // dateFormatter.timeZone = NSTimeZone.system
//        if Localization.sharedInstance.getLanguage() == CLanguageArabic {
//            dateFormatter.locale = Locale(identifier: "ar_DZ")
//        }
//        else {
 //         dateFormatter.locale = NSLocale.current
//        }
        return dateFormatter
    }()
    
    static func shared() -> DateFormatter {
        return sharedInstance
    }
    
    func string(fromDate:Date, dateFormat:String) -> String {
        self.dateFormat = dateFormat
        return self.string(from: fromDate)
    }
    
    func date(fromString:String, dateFormat:String) -> Date? {
        self.dateFormat = dateFormat
        return self.date(from: fromString)
    }
    
    func stringGMT(fromDate:Date, dateFormat: String) -> String {
        self.dateFormat = dateFormat
        DateFormatter.shared().timeZone = TimeZone(abbreviation: "GMT")
        return DateFormatter.shared().string(from: fromDate)
    }
    
    func dateGMT(fromString:String, dateFormat: String) -> Date? {
        self.dateFormat = dateFormat
        DateFormatter.shared().timeZone = TimeZone(abbreviation: "GMT")
        return DateFormatter.shared().date(from: fromString)
    }
}


extension DateFormatter {
    
    private static var sharedInstanceMIV: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        return dateFormatter
    }()
    
    static func sharedMIV() -> DateFormatter {
        return sharedInstanceMIV
    }
    
    func stringMIV(fromDate: Date, dateFormat: String) -> String {
        self.dateFormat = dateFormat
        return self.string(from: fromDate)
    }
    
    func dateMIV(fromString: String, dateFormat: String) -> Date? {
        self.dateFormat = dateFormat
        return self.date(from: fromString)
    }
}

extension DateFormatter {
    
    // To Get date string from timestamp
    static func dateStringFrom(timestamp: Double?, withFormate:String?) -> String {
        let fromDate:Date = Date(timeIntervalSince1970: timestamp!)
        DateFormatter.shared().locale = NSLocale.current
        DateFormatter.shared().timeZone = TimeZone.current
        /*
         if Localization.sharedInstance.getLanguage() == CLanguageArabic {
         DateFormatter.shared().locale = Locale(identifier: "ar_DZ")
         } else {
         DateFormatter.shared().locale = NSLocale.current
         }
         */
        return DateFormatter.shared().string(fromDate: fromDate, dateFormat: withFormate!)
    }
    
    // To Get date from timestamp
    func dateFrom(timestamp: String) -> Date? {
        let fromDate:Date = Date(timeIntervalSince1970: Double(timestamp)!)
        let stringDate = DateFormatter.shared().string(fromDate: fromDate, dateFormat: "dd MMM, YYYY")
        return DateFormatter.shared().date(fromString: stringDate, dateFormat: "dd MMM, YYYY")
    }
    
    // To get specific date string fromate from specific date string
    func convertDateFormat(date : String?, currentformate : String?, updateformate : String?) -> String? {
        let dateString = date
        var dateInfo = ""
        self.dateFormat = currentformate // "dd-MM-yyyy hh:mm a"
        
        if let strCurrnetDate = self.date(from: dateString!){
            self.dateFormat = updateformate //"dd-MMM-yyyy hh:mm a"
            dateInfo = self.string(from: strCurrnetDate)
        }
        
        return dateInfo
    }
    
    // To compare two date with same formate
    func compareTwoDates(startDate : String?, endDate : String?, formate : String?) -> Bool {
        self.dateFormat = formate
        self.timeZone = TimeZone(abbreviation: "GMT")
        let startDateTimeStamp = self.date(from: startDate!)?.timeIntervalSince1970
        let endDateTimeStamp = self.date(from: endDate!)?.timeIntervalSince1970
        return Double(endDateTimeStamp!) > Double(startDateTimeStamp!)
    }
    
    func convertDateIntoGMTDate(dateToConvert: String?,  formate : String?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        let convertedDate = formatter.date(from: dateToConvert ?? "")
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: convertedDate!)
    }
     
}

// MARK: - Timestamp Related Functions
extension DateFormatter {
    // To Get GMT Timestamp from Specific Date
    func timestampGMTFromDate(date : String?, formate : String?) -> Double? {
        self.dateFormat = formate
        self.timeZone = TimeZone(abbreviation: "GMT")
        var timeStamp = self.date(from: date!)?.timeIntervalSince1970
        timeStamp = Double(timeStamp!)
        return timeStamp
    }
    
    // To Get local Timestamp from specific date
    func timestampFromDate(date : String?, formate : String?) -> Double? {
        self.dateFormat = formate
        self.timeZone = TimeZone.current
        var timeStamp = self.date(from: date!)?.timeIntervalSince1970
        //        timeStamp = Double((timeStamp?.toFloat)!)
        timeStamp = Double(timeStamp!)
        return timeStamp
    }
    
    // To Get GMT Timestamp from current date.
    func currentGMTTimestampInMilliseconds() -> Double? {
        let format = "yyyy-MM-dd HH:mm:ss.SSSS'Z'"
        self.dateFormat = format
        self.timeZone = TimeZone(identifier: "GMT")
        
        let createDate = self.string(from: Date())
        let timestamp = self.timestampGMTFromDate(date: createDate, formate: format)
        return timestamp! * 1000
    }
    
    // To Convert GMT timestamp to local timestamp
    func ConvertGMTMillisecondsTimestampToLocalTimestamp(timestamp: Double) -> Double? {
        let format = "yyyy-MM-dd HH:mm:ss.SSSS'Z'"
        self.dateFormat = format
        self.timeZone = TimeZone.current
        let dateStr = NSDate(timeIntervalSince1970:timestamp)
        let createDate = self.string(from: dateStr as Date)
        let gmtTimestamp = self.timestampFromDate(date: createDate, formate: format)
        return gmtTimestamp
        
    }
    
}
