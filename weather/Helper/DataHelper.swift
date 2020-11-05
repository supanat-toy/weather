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
        return String(format: "%.\(point)f", number ?? 0)
    }
}
