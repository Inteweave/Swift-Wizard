//
//  SnackFactory.swift
//  Wizard
//
//  Created by Warren Milward on 26/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// This class is responsible for creating the view controller for the screen
///
class SnackFactory {
    enum InternalError: Error {
        case error
    }

    weak var delegate: EventDelegate?

    ///
    /// Given the identifier for a screen return the view controller
    /// This one just uses a simple view controller to illustrate navigation
    ///
    /// - parameter screen: The name of the screen
    /// - returns: The view controller
    ///
    func viewForScreen(screen: SnacksScreen) -> UIViewController {
        return SnacksViewController(screen: screen, eventDelegate: delegate)
    }
}
