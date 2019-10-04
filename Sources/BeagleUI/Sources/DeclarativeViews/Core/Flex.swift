//
//  Flex.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Flex {
    
    // MARK: - Public Properties
    
    public let flexWrap: Wrap
    public let justifyContent: JustifyContent
    public let alignItems: Alignment
    public let alignSelf: Alignment
    public let alignContent: Alignment
    public let basis: UnitValue
    public let grow: Double
    public let shrink: Int
    
    // MARK: - Public Properties
    
    public init (// TODO: Change this visibilty constraint in the future...
        flexWrap: Wrap = .no_wrap,
        justifyContent: JustifyContent = .flex_end,
        alignItems: Alignment = .stretch,
        alignSelf: Alignment = .auto,
        alignContent: Alignment = .flex_start,
        basis: UnitValue = UnitValue(value: 0.0, type: .real),
        grow: Double = 0.0,
        shrink: Int = 0
    ) {
        self.flexWrap = flexWrap
        self.justifyContent = justifyContent
        self.alignItems = alignItems
        self.alignSelf = alignSelf
        self.alignContent = alignContent
        self.basis = basis
        self.grow = grow
        self.shrink = shrink
    }
    
}

// MARK: - Flex ItemDirection
extension Flex {
    public enum ItemDirection: String, StringRawRepresentable {
        case inherit = "INHERIT"
        case ltr = "LTR"
        case rtl = "RTL"
    }
}

// MARK: - Flex Direction
extension Flex {
    public enum Direction: String, StringRawRepresentable {
        case row = "ROW"
        case row_reverse = "ROW_REVERSE"
        case column = "COLUMN"
        case column_reverse = "COLUMN_REVERSE"
    }
}

// MARK: - Flex Wrap
extension Flex {
    public enum Wrap: String, StringRawRepresentable {
        case no_wrap = "NO_WRAP"
        case wrap = "WRAP"
        case wrap_reverse = "WRAP_REVERSE"
    }
}

// MARK: - Flex JustifyContent
extension Flex {
    public enum JustifyContent: String, StringRawRepresentable {
        case flex_start = "FLEX_START"
        case center = "CENTER"
        case flex_end = "FLEX_END"
        case space_between = "SPACE_BETWEEN"
        case space_around = "SPACE_AROUND"
        case space_evenly = "SPACE_EVENLY"
    }
}

// MARK: - Flex Alignment
extension Flex {
    public enum Alignment: String, StringRawRepresentable {
        case flex_start = "FLEX_START"
        case center = "CENTER"
        case flex_end = "FLEX_END"
        case space_between = "SPACE_BETWEEN"
        case space_around = "SPACE_AROUND"
        case baseline = "BASELINE"
        case auto = "AUTO"
        case stretch = "STRETCH"
    }
}
