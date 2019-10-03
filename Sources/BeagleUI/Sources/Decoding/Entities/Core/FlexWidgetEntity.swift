//
//  FlexWidgetEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `FlexWidget`
struct FlexWidgetEntity: WidgetEntity {
    
    let children: [WidgetConvertibleEntity]
    let flex: FlexEntity
    
    private let childrenContainer: [WidgetEntityContainer]
    
    private enum CodingKeys: String, CodingKey {
        case childrenContainer = "children"
        case flex
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            childrenContainer: container.decode([WidgetEntityContainer].self, forKey: .childrenContainer),
            flex: container.decodeIfPresent(FlexEntity.self, forKey: .flex)
        )
    }
    
    init(
        childrenContainer: [WidgetEntityContainer],
        flex: FlexEntity?
    ) {
        self.childrenContainer = childrenContainer
        children = childrenContainer.compactMap { $0.content }
        self.flex = flex ?? FlexEntity()
    }
    
}
extension FlexWidgetEntity: WidgetConvertible, ChildrenWidgetMapping {

    func mapToWidget() throws -> Widget {

        let children = try mapChildren()
        let flex = try self.flex.mapToUIModel()

        return FlexWidget(
            children: children,
            flex: flex
        )
        
    }

}
