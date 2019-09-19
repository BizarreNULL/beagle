//
//  StyledWidgetEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `StyledWidget`
struct StyledWidgetEntity: WidgetEntity {
    let border: BorderEntity?
    let color: String?
    let child: WidgetEntityContainer?
}
extension StyledWidgetEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        var uiBorder: Border?
        if let border = border {
            uiBorder = Border(color: border.color, radius: border.radius, size: border.size)
        }
        let child = try? self.child?.content?.mapToWidget()
        return StyledWidget(border: uiBorder, color: color, child: child)
    }
}

/// Defines an API representation for `Border`
struct BorderEntity: WidgetEntity {
    let color: String?
    let radius: Double?
    let size: Double?
}
