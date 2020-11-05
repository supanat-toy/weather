//
//  Date+Extension.swift
//  weather
//
//  Created by Supanat on 3/11/2563 BE.
//

import Foundation
import UIKit

extension Date {
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: Double(milliseconds))
    }
    
    func formattedString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//
//extension Optional where Wrapped == Double {
//    func formattedDecimal(point: Int) -> String {
//        guard let value = self else {
//            return ""
//        }
//        return String(format: "%.\(point)f", value)
//    }
//}
