//
//  WizardError.swift
//  Wizard
//
//  Created by Warren Milward on 18/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import Foundation

///
/// Error thrown when an internal error occurs
///
enum WizardError<ScreenIdentifier>: Error {
    case multipleDefinitionsForScreen(identifier: ScreenIdentifier)
    case noEvent(_ eventName: String, foundForScreen: ScreenIdentifier)
}
