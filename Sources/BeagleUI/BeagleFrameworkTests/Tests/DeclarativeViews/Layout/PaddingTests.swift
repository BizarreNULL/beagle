//
//  PaddingTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 03/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class PaddingTests: XCTestCase {

    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Padding {
            Text("text")
        }

        // Then
        XCTAssertTrue(widget.child is Text, "Expected to find `Text`.")
    }
    
    func test_newClosure_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Padding.new(value: .zero) { () -> Widget in
            Text("Coisa")
        }

        // Then
        XCTAssertTrue(widget.child is Text, "Expected to find `Text`.")
    }
}
