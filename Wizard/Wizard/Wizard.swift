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
    var currentScreen: ScreenIdentifier
    var screenStack = [ScreenIdentifier]()
    let screenNavigations: [ScreenNavigation<ScreenIdentifier, WizardEvent>]

    ///
    /// Create an instance of the Wizard
    ///
    init(screenNavigations: [ScreenNavigation<ScreenIdentifier, WizardEvent>],
         startScreen: ScreenIdentifier) {
        self.screenNavigations = screenNavigations
        self.currentScreen = startScreen
    }

    ///
    /// An event was raised on the current screen
    ///
    /// - parameter event: The event that occurred on the current screen
    /// - returns: The *ScreenIdentifier* for the event
    ///
    func onEvent(event: WizardEvent) throws -> ScreenIdentifier {
        let navigations = screenNavigations.filter { $0.event == event && $0.from == currentScreen }
        switch navigations.count {
        case 1:
            screenStack.append(currentScreen)
            // we have navigated to the to screen so update the current screen
            currentScreen = navigations.first!.to
            return currentScreen
        case 0:
            throw WizardError.noEvent("\(event)", foundForScreen: currentScreen)
        default:
            throw WizardError.multipleDefinitionsForScreen(identifier: currentScreen)
        }
    }

    ///
    /// Used when the wizard has gone back a screen
    ///
    func back() {
        if let screenIdentifier = screenStack.popLast()  {
            currentScreen = screenIdentifier
        }
    }
}
