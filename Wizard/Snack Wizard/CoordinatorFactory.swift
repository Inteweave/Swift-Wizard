//
//  CoordinatorFactory.swift
//  Wizard
//
//  Created by Warren Milward on 18/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import Foundation

///
/// Factory method to create a coordinator given the screen identifier
///
protocol CoordinatorFactory {
    ///
    /// Create the coordinator for the screen
    /// We use Any as the parameter to avoid compiler error that it can only be used as a generic type

    associatedtype ScreenIdentifier
    ///
    /// - parameter screen: The screen to find the associated coordinator
    /// - returns: the coordinator or nil if one can't be found
    /// - throws:
    func coordinatorForScreen(screen: ScreenIdentifier) throws -> Coordinator
}
