//
//  BeagleScreenViewController.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 09/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

extension BeagleScreenViewController {
    public enum ScreenType {
        case remote(String)
        case declarative(Widget)
    }
}

public protocol BeagleScreenViewControllerDelegate: AnyObject {

    func beagleScreenViewController(
        _ controller: BeagleScreenViewController,
        didFailToLoadWithError error: Error
    )
}

public class BeagleScreenViewController: UIViewController {
    
    // MARK: - Dependencies
    
    let screenType: ScreenType

    var dependencies: Dependencies

    public typealias Dependencies =
        DependencyActionExecutor
        & DependencyRemoteConnector
        & RendererDependencies
    
    // MARK: - Properties
    
    weak var delegate: BeagleScreenViewControllerDelegate?
    
    weak var rootWidgetView: UIView?
    
    // MARK: - Initialization

    public init(
        screenType: ScreenType,
        dependencies: Dependencies? = nil
    ) {
        self.screenType = screenType
        self.dependencies = dependencies ?? Beagle.dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadScreen()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let widgetView = rootWidgetView?.subviews.first {
            widgetView.frame = (rootWidgetView ?? view).bounds
            dependencies.flex.applyYogaLayout(to: widgetView, preservingOrigin: true)
        }
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = .white
        }
        let rootView = UIView()
        rootView.backgroundColor = .clear
        rootView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rootView)
        
        let constraints: [NSLayoutConstraint]
        if #available(iOS 11.0, *) {
            let guide = view.safeAreaLayoutGuide
            constraints = [
                rootView.topAnchor.constraint(equalTo: guide.topAnchor),
                rootView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
                rootView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                rootView.leadingAnchor.constraint(equalTo: guide.leadingAnchor)
            ]
        } else {
            constraints = [
                rootView.topAnchor.constraint(equalTo: view.topAnchor),
                rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        }
        NSLayoutConstraint.activate(constraints)
        
        self.rootWidgetView = rootView
    }
    
    private func loadScreen() {
        switch screenType {
        case let .declarative(widget):
            loadDeclarativeScreenWithRootWidget(widget, context: self)
        case let .remote(url):
            loadScreenFromURL(url)
        }
    }
    
    // MARK: - Declarative Screen Loading
    
    private func loadDeclarativeScreenWithRootWidget(_ widget: Widget, context: BeagleContext) {
        let view = widget.toView(context: context, dependencies: dependencies)
        setupWidgetView(view)
    }
    
    // MARK: - Remote Screen Loading
    
    private func loadScreenFromURL(_ url: String) {
        view.showLoading(.whiteLarge)
        dependencies.remoteConnector.fetchWidget(from: url) { [weak self] result in
            self?.view.hideLoading()
            switch result {
            case let .success(widget):
                self?.buildViewFromWidget(widget)
            case let .failure(error):
                self?.handleError(error)
            }
        }
    }
    
    // MARK: - View Setup

    private func buildViewFromWidget(_ widget: Widget) {
        let view = widget.toView(context: self, dependencies: dependencies)
        setupWidgetView(view)
    }
    
    private func setupWidgetView(_ widgetView: UIView) {
        rootWidgetView?.addSubview(widgetView)
        widgetView.frame = (rootWidgetView ?? view).bounds
        dependencies.flex.applyYogaLayout(to: widgetView, preservingOrigin: true)
    }
    
    // MARK: - Error Handling
    
    func handleError(_ error: Error) {
        delegate?.beagleScreenViewController(self, didFailToLoadWithError: error)
    }
    
}
