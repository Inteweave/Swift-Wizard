//
//  ViewController.swift
//  Wizard
//
//  Created by Warren Milward on 18/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var controller: SnackWizardController?

    @IBAction func onStart(_ sender: Any) {
        controller = SnackWizardController(navigationController: navigationController!)
        controller!.startWizard {
            self.navigationController?.popToRootViewController(animated: true)
            self.controller = nil
        }
    }

}
