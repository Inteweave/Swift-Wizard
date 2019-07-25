//
//  ScreenNavigation.swift
//  Wizard
//
//  Created by Warren Milward on 18/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import Foundation

///
/// This is the actual navigation
/// There is one of these created for each possible event for each screen
/// This can follow the UX flow; requirement is that each screen has a name
///
struct ScreenNavigation<ScreenIdentifier, WizardEvent> {
    let onScreen: ScreenIdentifier
    let when: WizardEvent
    let navigateTo: ScreenIdentifier
}
