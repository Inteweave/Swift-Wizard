//
//  SnackWizardController.swift
//  Wizard
//
//  Created by Warren Milward on 18/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

typealias SnackWizard = Wizard<SnacksScreen, Event>

///
/// Sample wizard to enable the user to select a snack
///```
/// Flows are:
/// - choose snack
///   - icecream
///     - scoop
///     - soft serve
///       - choc dip
///       - sprinkles
///  - nuts
///```
///
/// This class is responsible for creating and showing view controllers
/// and for defining the screen navigation. For a real app the screen navigations would probably be
/// in its own file.
///
/// To add a screen, you would normally:
/// - code view controller, presenter and .xib
/// - add an identifier for the screen
/// - add the creation of the view controller to the factory
/// - add any new events raised by the screen
/// - add navigations for events going to the screen and handling the events from the screen
///
class SnackWizardController: EventDelegate {

    let navigationController: UINavigationController
    let wizard: SnackWizard
    let factory: SnackFactory
    var completion: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        wizard = SnackWizard(screenNavigations: SnackWizardController.screenNavigations)
        factory = SnackFactory()
        factory.delegate = self
    }

    ///
    /// Start the wizard
    ///
    /// - parameter completion: Completion block to be invoked when the wizard finishes or is cancelled.
    ///
    func startWizard(completion: @escaping () -> Void) {
        self.completion = completion
        let viewController = factory.viewForScreen(screen: SnacksScreen.selectType)
        navigationController.pushViewController(viewController, animated: true)
    }

    ///
    /// The user has selected an action
    ///  Use the wizard to determine the next screen and instantiate it
    ///
    /// - parameter event: The event raised
    ///
    func event(_ event: Event, wasRaisedOnScreen screen: SnacksScreen) {
        if event == .finish {
            completion?()
        } else if let screenIdentifier = try? wizard.event(event: event, wasRaisedOnScreen: screen) {
            let viewController = factory.viewForScreen(screen: screenIdentifier)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - Screen Navigation

///
/// For a substantial UX flow, this will probably be in its own file
/// If there is a cancel button, each screen might also define an action for the finish event
///
extension SnackWizardController {
    static let screenNavigations = [
        // from screen, on event, navigate to screen
        ScreenNavigation(onScreen: SnacksScreen.selectType,
                         when: Event.userDidChooseIceCream,
                         navigateTo: SnacksScreen.iceCreamServe),

        ScreenNavigation(onScreen: SnacksScreen.iceCreamServe,
                         when: Event.userDidChooseSoftServe,
                         navigateTo: SnacksScreen.chooseTopping),
        ScreenNavigation(onScreen: SnacksScreen.iceCreamServe,
                         when: Event.userDidChooseIceCreamScoop,
                         navigateTo: SnacksScreen.scoop),

        ScreenNavigation(onScreen: SnacksScreen.chooseTopping,
                         when: Event.userDidChooseChocDip,
                         navigateTo: SnacksScreen.softServeChocDip),
        ScreenNavigation(onScreen: SnacksScreen.chooseTopping,
                         when: Event.userDidChooseSprinkles,
                         navigateTo: SnacksScreen.softServeSprinkles),

        ScreenNavigation(onScreen: SnacksScreen.selectType,
                         when: Event.userDidChooseNuts,
                         navigateTo: SnacksScreen.nuts)
    ]
}
