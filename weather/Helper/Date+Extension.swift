//
//  Date+Extension.swift
//  weather
//
//  Created by Supanat on 3/11/2563 BE.
//

import Foundation

extension Date {
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func formattedString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
