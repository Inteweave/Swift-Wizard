//
//  SnacksViewPresenter.swift
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
    func event(_ event: Event, wasRaisedOnScreen: SnacksScreen)
}

///
/// View Presenter for the snacks screen
/// This is a template and we just change the contents
///
class SnacksViewPresenter {

    let screen: SnacksScreen
    weak var eventDelegate: EventDelegate?

    ///
    /// Returns a newly created presenter initialised for the specified screen
    ///
    /// - parameter screen: The *ScreenName* of the screen to display
    /// - returns: The newly created presenter
    ///
    init(screen: SnacksScreen) {
         self.screen = screen
    }

}

// MARK: - Snacks View content

extension SnacksViewPresenter {
    var label: String {
        return screen.contents.label
    }

    var button1Title: String {
        return screen.contents.button1Title
    }

    var button2Title: String {
        return screen.contents.button2Title
    }

    var button2Hidden: Bool {
        return screen.contents.button2Hidden
    }

    func button1Pressed() {
        eventDelegate?.event(screen.contents.button1Event, wasRaisedOnScreen: screen)
    }

    func button2Pressed() {
        eventDelegate?.event(screen.contents.button2Event, wasRaisedOnScreen: screen)
    }
}
