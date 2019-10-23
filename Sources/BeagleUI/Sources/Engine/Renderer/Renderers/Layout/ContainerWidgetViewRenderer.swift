//
//  ContainerViewRenderer.swift
//  BeagleUI
//
//  Created by Daniel Tes on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ContainerWidgetViewRenderer: WidgetViewRenderer<Container> {
    
    // MARK: - Public Functions
    
    override func buildView() -> UIView {
        
        let view = UIView(frame: .zero)
        let flex = Flex(flexDirection: .column, justifyContent: .spaceBetween)
        
        if let header = widget.header {
            let headerView = rendererProvider.buildRenderer(for: header).buildView()
            headerView.backgroundColor = .red
            view.addSubview(headerView)
        }
        
        let scrollView = buildContentScrollView()
        scrollView.backgroundColor = .green
        view.addSubview(scrollView)
        
        if let footer = widget.footer {
            let footerView = rendererProvider.buildRenderer(for: footer).buildView()
            footerView.backgroundColor = .gray
            view.addSubview(footerView)
        }
        
        flexViewConfigurator.applyFlex(flex, to: view)
        
        return view
    }
    
    // MARK: - Private Functions
    
    private func buildContentScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: .zero)
        let flex = Flex(grow: 1)
        
        let contentView = rendererProvider.buildRenderer(for: widget.content).buildView()
        scrollView.addSubview(contentView)
        
        flexViewConfigurator.applyFlex(flex, to: scrollView)
        
        return scrollView
    }
    
}
