//
//  Wizard.swift
//  Wizard
//
//  Created by Warren Milward on 18/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import Foundation

///
/// The wizard class is the engine that drives the navigation
/// Given the screen navigations and the events it determines the identifier for the
/// next screen
/// * **ScreenIdentifier**: The type of the screen identifier; normally an enum
/// * **WizardEvent**: The type of the event raised; normally an enum
///
class Wizard<ScreenIdentifier: Equatable, WizardEvent: Equatable> {

    let screenNavigations: [ScreenNavigation<ScreenIdentifier, WizardEvent>]

    ///
    /// Create an instance of the Wizard
    ///
    init(screenNavigations: [ScreenNavigation<ScreenIdentifier, WizardEvent>]) {
        self.screenNavigations = screenNavigations
    }

    ///
    /// An event was raised on the current screen
    ///
    /// - parameter event: The event that occurred on the current screen
    /// - returns: The *ScreenIdentifier* for the event
    ///
    func event(event: WizardEvent, wasRaisedOnScreen currentScreen: ScreenIdentifier) throws -> ScreenIdentifier {
        let navigations = screenNavigations.filter { $0.when == event && $0.onScreen == currentScreen }
        switch navigations.count {
        case 1:
            return navigations.first!.navigateTo
        case 0:
            throw WizardError.noEvent("\(event)", foundForScreen: currentScreen)
        default:
            throw WizardError.multipleDefinitionsForScreen(identifier: currentScreen)
        }
    }

}
