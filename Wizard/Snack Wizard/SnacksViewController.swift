//
//  SnacksViewController.swift
//  Wizard
//
//  Created by Warren Milward on 19/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Delegate for the view
///
protocol SnacksViewDelegate: AnyObject {
    var label: String { get }
    var button1Title: String { get }
    var button2Title: String { get }
    var button2Hidden: Bool { get }

    func button1Pressed()
    func button2Pressed()
}

///
/// Simple view controller to act as a template for all view controllers
/// The template is filled with information from the coordinator
///
/// A real app would probably have a number of templates or just view controllers
///
class SnacksViewController: UIViewController {

    weak var delegate: SnacksViewDelegate?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    // this view controller is just for demonstration purposes

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = delegate?.label
        button1.setTitle(delegate?.button1Title, for: .normal)
        button2.setTitle(delegate?.button2Title, for: .normal)
        button2.isHidden = delegate?.button2Hidden ?? true
    }

    @IBAction func onButton1(_ sender: Any) {
        delegate?.button1Pressed()
    }
    
    @IBAction func onButton2(_ sender: Any) {
        delegate?.button2Pressed()
    }
    
}
