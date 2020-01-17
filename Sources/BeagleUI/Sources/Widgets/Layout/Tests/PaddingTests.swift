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
        let widget = Padding(child: Text("text"))

        // Then
        XCTAssert(widget.child is Text)
    }
}
