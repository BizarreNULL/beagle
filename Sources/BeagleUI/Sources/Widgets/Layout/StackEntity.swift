//
//  StackEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct StackEntity: WidgetConvertibleEntity {
    
    let appearance: AppearanceEntity?
    let children: [AnyDecodableContainer]
    
    func mapToWidget() throws -> Widget {
        
        let children = try self.children.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        
        return Stack(
            appearance: try appearance?.mapToUIModel(),
            children: children
        )
    }
}
