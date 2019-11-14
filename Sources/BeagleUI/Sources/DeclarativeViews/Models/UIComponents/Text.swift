//
//  Text.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Text: NativeWidget {
    
    // MARK: - Public Properties
    
    public let text: String
    public let style: String?
    
    public init(
        _ text: String,
        style: String? = nil
    ) {
        self.text = text
        self.style = style
    }
    
}
