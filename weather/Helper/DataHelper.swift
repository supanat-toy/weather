//
//  DataHelper.swift
//  weather
//
//  Created by Supanat on 5/11/2563 BE.
//

import Foundation
import UIKit

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
    
    func getFont(fontFamily: FontFamily, size: CGFloat) -> UIFont {
        return UIFont(name: fontFamily.rawValue, size: size) ?? UIFont()
    }
}

enum FontFamily: String {
    case avenirBlack = "Avenir-Black"
    case avenirBook = "Avenir-Book"
    case avenirHeavy = "Avenir-Heavy"
    case avenirMedium = "Avenir-Medium"
    case avenirNextBold = "AvenirNext-Bold"
    case avenirNextHeavy = "AvenirNext-Heavy"
    case avenirNextMedium = "AvenirNext-Medium"
    case avenirNextRegular = "AvenirNext-Regular"
}
    
