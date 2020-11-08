//
//  DataHelper.swift
//  weather
//
//  Created by Supanat on 5/11/2563 BE.
//

import Foundation

class DataHelper {
    static let shared = DataHelper()
    
    func formattNumberDecimal(number: Double?, point: Int) -> String {
        if number == nil {
            return ""
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = point
        formatter.maximumFractionDigits = point
        
        return formatter.string(for: number) ?? "0"
    }
}
