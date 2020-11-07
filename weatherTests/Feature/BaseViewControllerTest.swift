//
//  BaseViewControllerTest.swift
//  weatherTests
//
//  Created by Supanat on 7/11/2563 BE.
//

import Foundation
import XCTest
@testable import weather

class BaseViewControllerTest: XCTestCase {
    
    var mockBaseViewController: MockBaseViewController!
    let titleLabel = UILabel(frame: .zero)
    
    override func setUp() {
        super.setUp()
        
        mockBaseViewController = MockBaseViewController()
    }
    
    func testAlertIsCalledPresent() {
        mockBaseViewController.alert(title: "title 1", message: "message 1")
        XCTAssertTrue(mockBaseViewController.isCalledPresent)
    }
    
    func testAlertErrorIsCalledPresent() {
        mockBaseViewController.alertError(message: "message error")
        XCTAssertTrue(mockBaseViewController.isCalledPresent)
    }
    
    func testStatusBarLightContent() {
        XCTAssertEqual(.lightContent, mockBaseViewController.statusBarStyle)
    }
    
    func testDismissLoadingViewIsRemoveFromSuperview() {
        let mockLoadingView = MockLoadingView()
        mockBaseViewController.alertLoadingView = mockLoadingView
        mockBaseViewController.dismissLoadingView {}
        
        XCTAssertTrue(mockLoadingView.isCalledRemoveFromSuperview)
    }
    
    func testShowLoadingViewSetTitleLoading() {
        let mockLoadingView = MockLoadingView()
        mockLoadingView.titleLabel = titleLabel
        
        mockBaseViewController.alertLoadingView = mockLoadingView
        mockBaseViewController.showLoadingView()
        
        XCTAssertEqual("Loading...", mockLoadingView.titleLabel.text)
    }
}

class MockBaseViewController: BaseViewController {
    var isCalledPresent = false
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        isCalledPresent = true
    }
}

class MockLoadingView: LoadingView {
    var isCalledRemoveFromSuperview = false
    
    override func removeFromSuperview() {
        isCalledRemoveFromSuperview = true
    }
}
