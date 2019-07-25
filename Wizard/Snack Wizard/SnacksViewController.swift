//
//  SnacksViewController.swift
//  Wizard
//
//  Created by Warren Milward on 19/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Simple view controller to act as a template for all screens
/// The template is filled with information from the view presenter
///
/// A real app would probably have a number of templates and maybe some screen-specific view controllers
///
class SnacksViewController: UIViewController {

    // hold a strong reference to the presenter so that the memory is managed by the system
    // as it removes view controllers
    var viewPresenter: SnacksViewPresenter?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    // this view controller is just for demonstration purposes

    init(screen: SnacksScreen, eventDelegate: EventDelegate?) {
        super.init(nibName: nil, bundle: nil)
        viewPresenter = SnacksViewPresenter(screen: screen)
        viewPresenter?.eventDelegate = eventDelegate
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = viewPresenter?.label
        button1.setTitle(viewPresenter?.button1Title, for: .normal)
        button2.setTitle(viewPresenter?.button2Title, for: .normal)
        button2.isHidden = viewPresenter?.button2Hidden ?? true
    }

    @IBAction func onButton1(_ sender: Any) {
        viewPresenter?.button1Pressed()
    }

    @IBAction func onButton2(_ sender: Any) {
        viewPresenter?.button2Pressed()
    }

}
