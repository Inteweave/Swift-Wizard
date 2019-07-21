//
//  NavigationControllerDelegate.swift
//  Wizard
//
//  Created by Warren Milward on 20/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Simple protocol to inform that the back button on a view controller has been pressed
///
protocol DidGoBackDelegate: AnyObject {
    func backButtonPressed()
}


///
/// Class to detect when a view controller is popped from the navigation controller stack.
///
/// Unfortunately iOS doesn't provide this directly, so we use a UINavigationControllerDelegate
/// and detect when a view controller is shown.
///
class BackButtonEventDetector: NSObject, UINavigationControllerDelegate {
    weak var delegate: DidGoBackDelegate?
    var viewControllersSeen = [UIViewController]()
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController === navigationController.viewControllers[0] {
            // we have exited the wizard; back to the home page.
            delegate?.backButtonPressed()
            viewControllersSeen.removeAll()
        } else if viewControllersSeen.contains(viewController) {
            // we are going back.
            // remove the view controller we are coming back from from the list of seen view controllers
            viewControllersSeen.removeLast(1)
            delegate?.backButtonPressed()
        } else {
            // we are going forward
            viewControllersSeen.append(viewController)
        }
    }
}
