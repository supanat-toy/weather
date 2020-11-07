//
//  NetworkErrorTest.swift
//  weatherTests
//
//  Created by Supanat on 7/11/2563 BE.
//

import Foundation
import XCTest
import Moya

@testable import weather

class NetworkErrorTest: XCTestCase {
    
    var networkError: NetworkError!
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testA() {
        let error = """
                    {
                    "cod": "Error-150",
                    "message": "Something is wrong or not !!"
                    }
            """
        let response = Response(statusCode: 500, data: error.data(using: .utf8)!)
        
        networkError = NetworkError(response: response)
        
        XCTAssertEqual("Error-150", networkError.code)
        XCTAssertEqual("Something is wrong or not !!", networkError.message)
        XCTAssertEqual(500, networkError.httpStatusCode)
    }
    
    func testB() {
        let error = """
                    {
                    "codAAA": "Error-150",
                    "messageAAA": "Something is wrong or not !!"
                    }
            """
        let response = Response(statusCode: 550, data: error.data(using: .utf8)!)
        
        networkError = NetworkError(response: response)
        
        XCTAssertNil(networkError.code)
        XCTAssertNil(networkError.message)
        XCTAssertEqual(550, networkError.httpStatusCode)
    }
    
    func testC() {
        let response = Response(statusCode: 510, data: Data())
        
        networkError = NetworkError(response: response)
        
        XCTAssertNil(networkError.code)
        XCTAssertEqual("Status Code: 510, Data Length: 0", networkError.message)
        XCTAssertEqual(510, networkError.httpStatusCode)
    }
}
