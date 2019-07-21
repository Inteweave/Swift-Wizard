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
///     - cone
///     - soft serve
///       - choc dip
///       - sprinkles
///  - nuts
///```
///
/// This class is responsible for creating and starting coordinators
/// and for defining the screen navigation. For a real app the screen navigations would probably be
/// in its own file.
///
/// To add a screen, you would normally:
/// - code the coordinator, view controller and .xib
/// - add an identifier for the screen
/// - add the creation of the coordinator to the factory
/// - add any new events raised by the screen
/// - add navigations for events going to the screen and handling the events from the screen
///
///
class SnackWizardController: DidGoBackDelegate, EventDelegate {

    let wizard: SnackWizard
    var coordinators = [Coordinator]()
    let backButtonEventDetector = BackButtonEventDetector()
    let factory: Factory
    var completion: (() -> Void)?

    init(navigationController: UINavigationController) {
        factory = Factory(navigationController: navigationController)
        wizard = SnackWizard(screenNavigations: SnackWizardController.screenNavigations, startScreen: SnacksScreen.selectType)
        backButtonEventDetector.delegate = self
        navigationController.delegate = backButtonEventDetector
    }

    ///
    /// Start the wizard
    ///
    /// - parameter completion: Completion block to be invoked when the wizard finishes or is cancelled.
    ///
    func startWizard(completion: @escaping () -> Void) {
        self.completion = completion
        factory.delegate = self
        let coordinator = factory.coordinatorForScreen(screen: wizard.currentScreen)
        coordinators.append(coordinator)
        coordinator.start()
    }

    ///
    /// The user has pressed the back button. This event is not controlled by the wizard.
    /// Tell the wizard that it needs to pop a screen so that its current screen remains correct.
    /// Remove the last coordinator, or complete the wizard if it is the initial screen of the wizard
    ///
    func backButtonPressed() {
        wizard.back()
        if coordinators.count == 1 {
            completion?()
        } else {
            coordinators.removeLast(1)
        }
    }

    ///
    /// The user has selected an action
    ///  Use the wizard to determine the next screen and instantiate it
    ///
    /// - parameter event: The event raised
    ///
    func onSnackSelection(_ event: Event) {
        if event == .finish {
            completion?()
        } else if let screenIdentifier = try? wizard.onEvent(event: event) {
            let coordinator = factory.coordinatorForScreen(screen: screenIdentifier)
            coordinators.append(coordinator)
            coordinator.start()
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
        ScreenNavigation(from: SnacksScreen.selectType, event: Event.userDidChooseIceCream, to: SnacksScreen.iceCreamServe),

        ScreenNavigation(from: SnacksScreen.iceCreamServe, event: Event.userDidChooseSoftServe, to: SnacksScreen.chooseTopping),
        ScreenNavigation(from: SnacksScreen.iceCreamServe, event: Event.userDidChooseIceCreamCone, to: SnacksScreen.cone),

        ScreenNavigation(from: SnacksScreen.chooseTopping, event: Event.userDidChooseChocDip, to: SnacksScreen.softServeChocDip),
        ScreenNavigation(from: SnacksScreen.chooseTopping, event: Event.userDidChooseSprinkles, to: SnacksScreen.softServeSprinkles),

        ScreenNavigation(from: SnacksScreen.selectType, event: Event.userDidChooseNuts, to: SnacksScreen.nuts)
    ]
}

// MARK: - Factory

///
/// This class is responsible for creating the coordinator for the screen
///
class Factory: CoordinatorFactory {
    enum InternalError: Error {
        case error
    }

    let navigationController: UINavigationController
    weak var delegate: EventDelegate?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    ///
    /// Given the identifier for a screen return the coordinator
    /// This one just uses a simple coordinator to illustrate navigation
    ///
    /// - parameter screen: The name of the screen
    /// - returns: The corrdinator
    ///
    func coordinatorForScreen(screen: SnacksScreen) -> Coordinator {
        let coordinator = SnacksCoordinator(navigationController: navigationController, screen: screen)
        coordinator.eventDelegate = delegate!
        return coordinator
    }
}

// MARK: - Events

///
/// The event names used
/// For many wizards there are standard events used by many screens such as *next*, *cancel* or *finish*
///
enum Event {
    case userDidChooseIceCream
    case userDidChooseIceCreamCone
    case userDidChooseSoftServe
    case userDidChooseChocDip
    case userDidChooseSprinkles
    case userDidChooseNuts
    case finish
}
