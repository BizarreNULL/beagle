//
//  LoadingViewTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 04/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LoadingViewTests: XCTestCase {
    
    func test_activityIndicatorStyle_shouldUpdate_activityIndicator() {
        // Given
        let sut = LoadingView()
        XCTAssertEqual(sut.activityIndicatorStyle, .whiteLarge, "Expected `whiteLarge`, but got \(String(describing: sut.activityIndicatorStyle)).")
        
        // When
        sut.activityIndicatorStyle = .gray
        
        // Then
        XCTAssertEqual(sut.activityIndicatorStyle, .gray, "Expected `whiteLarge`, but got \(String(describing: sut.activityIndicatorStyle)).")
    }
    
    func test_awakeFromNib_shouldCallSetup() {
        // Given
        let sut = LoadingView()
        
        // When
        sut.awakeFromNib()
        let containsBlurView = sut.subviews.contains {
            $0.alpha == 0.25 && $0.backgroundColor == .black
        }
        let containsActivityIndicator = sut.subviews.contains { $0 is UIActivityIndicatorView }
        
        // Then
        XCTAssertEqual(LoadingView.tag, sut.tag, "Expected \(LoadingView.tag), but got \(sut.tag).")
        XCTAssertEqual(2, sut.subviews.count, "Expected 2 subviews, but got \(sut.subviews.count).")
        XCTAssertTrue(containsBlurView, "The `LoadingView` should contain the `blurView`.")
        XCTAssertTrue(containsActivityIndicator, "The `LoadingView` should contain the `activityIndicator`.")
    }
    
    func test_startAnimating() {
        // Given
        let sut = LoadingView()
        let activityIndicator = sut.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
        
        // When
        sut.startAnimating()
        
        // Then
        XCTAssertEqual(activityIndicator?.isAnimating, true, "`activityIndicator` should be animating.")
    }
    
    func test_stopAnimating() {
        // Given
        let sut = LoadingView()
        sut.startAnimating()
        let activityIndicator = sut.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
        
        // When
        sut.stopAnimating()
        
        // Then
        XCTAssertEqual(activityIndicator?.isAnimating, false, "`activityIndicator` should not be animating.")
    }
    
}