//
//  FlexWidget.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FlexWidget: NativeWidget {
    
    // MARK: - Public Properties
    
    public let children: [Widget]
    public let flex: Flex
    
    // MARK: - Initialization
    
    init(
        children: [Widget],
        flex: Flex = Flex()
    ) {
        self.children = children
        self.flex = flex
    }
    
    public init(
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let singleChild = childBuilder()
        self.init(children: [singleChild])
    }
    
    public static func new(
        closure: () -> Widget
    ) -> FlexWidget {
        let children = closure()
        return .init(children: [children])
    }
    
    public init(
        @WidgetArrayBuilder _ childrenBuilder: () -> [Widget]
    ) {
        let children = childrenBuilder()
        self.init(children: children)
    }
    
    public static func new(
        _ closure: () -> [Widget]
    ) -> FlexWidget {
        let children = closure()
        return .init(children: children)
    }
    
   // MARK: - Configuration
    
    public func applyFlex(
        direction: Flex.Direction? = nil,
        flexDirection: Flex.FlexDirection? = nil,
        flexWrap: Flex.Wrap? = nil,
        justifyContent: Flex.JustifyContent? = nil,
        alignItems: Flex.Alignment? = nil,
        alignSelf: Flex.Alignment? = nil,
        alignContent: Flex.Alignment? = nil,
        positionType: Flex.PositionType? = nil,
        basis: UnitValue? = nil,
        flex: Double? = nil,
        grow: Double? = nil,
        shrink: Double? = nil,
        display: Flex.Display? = nil,
        size: Flex.Size? = nil,
        margin: Flex.EdgeValue? = nil,
        padding: Flex.EdgeValue? = nil,
        position: Flex.EdgeValue? = nil
    ) -> FlexWidget {
        let flex = Flex(
            direction: direction,
            flexDirection: flexDirection,
            flexWrap: flexWrap,
            justifyContent: justifyContent,
            alignItems: alignItems,
            alignSelf: alignItems,
            alignContent: alignContent,
            positionType: positionType,
            basis: basis,
            flex: flex,
            grow: grow,
            shrink: shrink,
            display: display,
            size: size,
            margin: margin,
            padding: padding,
            position: position
        )
        return FlexWidget(children: children, flex: flex)
    }
    
}
