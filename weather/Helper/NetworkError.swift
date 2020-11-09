//
//  NetworkError.swift
//  weather
//
//  Created by Supanat on 5/11/2563 BE.
//

import Foundation
import Moya

struct NetworkError: Swift.Error, Equatable, Codable {
    var code: String?
    var message: String?
    var httpStatusCode: Int?
    
    init(error: Error) {
        
        if let moyaError = error as? MoyaError {
            switch moyaError {
            case .objectMapping(_, let response):
                self = NetworkError(response: response)
            case .underlying(_, let response):
                self = NetworkError(response: response)
            case .statusCode(let response):
                self = NetworkError(response: response)
            default:
                self = NetworkError(code: nil, message: "Connection error", httpStatusCode: 0)
            }
        } else {
            self = error as? NetworkError ?? NetworkError(code: nil, message: error.localizedDescription, httpStatusCode: 0)
        }
    }
    
    init(code: String?, message: String?, httpStatusCode: Int?) {
        self.code = code
        self.message = message
        self.httpStatusCode = httpStatusCode
    }
    
    init(response: Response?) {
        if let response = response {
            if let json = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                self = NetworkError(code: json["cod"] as? String,
                                    message: json["message"] as? String,
                                    httpStatusCode: response.statusCode)
            } else {
                self = NetworkError(code: nil, message: response.description, httpStatusCode: response.statusCode)
            }
        }
    }
}
