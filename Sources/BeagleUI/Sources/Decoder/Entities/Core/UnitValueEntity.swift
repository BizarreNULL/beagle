//
//  UnitValueEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

struct UnitValueEntity: WidgetEntity {
    let value: Double
    let type: UnitTypeEntity
}

enum UnitTypeEntity: String, WidgetEntity {
    case real
    case percent
}
