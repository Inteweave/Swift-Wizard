//
//  SnacksCoordinator.swift
//  Wizard
//
//  Created by Warren Milward on 19/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

protocol EventDelegate: AnyObject {
    ///
    /// Raise the user event
    ///
    func onSnackSelection(_ event: Event)
}

///
/// Coordinator for the snacks screen
/// This is a template and we just change the contents
///
class SnacksCoordinator: Coordinator {

    let navigationController: UINavigationController
    let screenContents: ScreenContents
    weak var eventDelegate: EventDelegate?

    ///
    /// Returns a newly created coordinator initialised for the specified screen
    ///
    /// - parameter navigationController: The navigation controller that will display the screen
    /// - parameter screen: The *ScreenName* of the screen to display
    /// - returns: The newly created coordinator
    ///
    init(navigationController: UINavigationController, screen: SnacksScreen) {
        self.navigationController = navigationController
        screenContents = screen.contents
    }

    ///
    /// Display the view controller
    ///
    func start() {
        let viewController = SnacksViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - SnacksViewDelegate

extension SnacksCoordinator: SnacksViewDelegate {
    var label: String {
        return screenContents.label
    }

    var button1Title: String {
        return screenContents.button1Title
    }

    var button2Title: String {
        return screenContents.button2Title
    }

    var button2Hidden: Bool {
        return screenContents.button2Hidden
    }

    func button1Pressed() {
        eventDelegate?.onSnackSelection(screenContents.button1Event)
    }

    func button2Pressed() {
        eventDelegate?.onSnackSelection(screenContents.button2Event)
    }
}
