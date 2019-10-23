//
//  UIView+LoadingTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 18/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class UIViewLoadingTests: XCTestCase {
    
    func test_showLoading() {
        // Given
        let view = UIView()
        
        // When
        view.showLoading()
        
        // Then
        XCTAssertNotNil(view.viewWithTag(LoadingView.tag), "The view should contain a `LoadingView`.")
    }
    
    func test_hideLoading() {
        // Given
        let view = UIView()
        view.showLoading()
        let theViewHadALoadingView = view.viewWithTag(LoadingView.tag) != nil
        
        // When
        view.hideLoading()
        let loadingViewWasRemovedExpectation = expectation(description: "loadingViewWasRemovedExpectation")
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.26) {
            loadingViewWasRemovedExpectation.fulfill()
        }
        wait(for: [loadingViewWasRemovedExpectation], timeout: 0.5)
        
        // Then
        XCTAssertTrue(theViewHadALoadingView, "The view had a `LoadingView` that needed to be hidden.")
        XCTAssertNil(view.viewWithTag(LoadingView.tag), "The view should not contain a `LoadingView`.")
    }
    
}
