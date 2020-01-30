//
//  TextEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TextEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAText() {
        // Given
        let sut = TextEntity(text: "text")
        
        // When
        let text = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(text, "The Text widget should not be nil.")
        XCTAssertTrue(text is Text)
    }

}
