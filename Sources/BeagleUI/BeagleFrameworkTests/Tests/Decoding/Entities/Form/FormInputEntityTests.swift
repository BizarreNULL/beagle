//
//  InputWidgetEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 13/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class InputWidgetEntityTests: XCTestCase {
    
    func test_whenDecodingAValidJson_itShouldReturnAValidObject() {
        let json = """
            {
                "_beagleType_": "beagle:widget:forminput",
                "name": "some-form",
                "required": false,
                "validator": "some-validator",
                "child": {
                    "_beagleType_": "beagle:widget:text",
                    "text": "Some Text"
                }
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: FormInput.self, from: jsonData)
        
        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.child, "Expected object to have a single child, but found nil.")
    }
    
    func test_whenDecodingAnInvalidChild_itShouldThrowDecodingError() {
        // Given
        let childContainer = WidgetEntityContainer(type: "beagle:Text", content: nil)

        // When /Then
        XCTAssertThrowsError(
            _ = try FormInputEntity(
                name: "",
                required: false,
                validator: "coisa",
                childContainer: childContainer
            ),
            "Expected to throw an error, but got none.") { error in
                XCTAssertTrue(
                    error is WidgetDecodingError,
                    "Expected a `WidgetDecodingError`, but got \(error.localizedDescription)."
                )
        }
    }
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAFormEntity() {
        // Given
        let childContainer = WidgetEntityContainer(type: "beagle:widget:text", content: TextEntity(text: "text"))
        guard let sut = try? FormInputEntity(
            name: "",
            required: false,
            validator: "coisa",
            childContainer: childContainer
        ) else {
            XCTFail("Could not create sut.")
            return
        }
        
        // When
        let form = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(form, "FormInput widget should not be nil.")
        XCTAssertTrue(form is FormInput)
    }
    
}
