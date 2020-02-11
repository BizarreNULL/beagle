//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Container: Widget {
    
    // MARK: - Public Properties
    public let children: [ServerDrivenComponent]
    
    public let flex: Flex?
    public let appearance: Appearance?
    
    // MARK: - Initialization
    
    public init(
        children: [ServerDrivenComponent],
        flex: Flex? = nil,
        appearance: Appearance? = nil
    ) {
        self.children = children
        self.flex = flex
        self.appearance = appearance
    }
    
   // MARK: - Configuration
    
    public func applyFlex(_ flex: Flex) -> Container {
        return Container(children: children, flex: flex, appearance: appearance)
    }
}

extension Container: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let containerView = UIView()
        
        children.forEach {
            let childView = $0.toView(context: context, dependencies: dependencies)
            containerView.addSubview(childView)
            dependencies.flex.enableYoga(true, for: childView)
        }
        
        containerView.applyAppearance(appearance)
        dependencies.flex.setupFlex(flex, for: containerView)
        
        return containerView
    }
}
