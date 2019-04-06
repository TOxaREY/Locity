//
//  ViewController.swift
//  Label up
//
//  Created by REYNIKOV ANTON on 06/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var www: UIView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()



    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.center.x = www.center.x // Place it in the center x of the view.
        label.center.x -= www.bounds.width // Place it on the left of the view with the width = the bounds'width of the view.
        // animate it from the left to the right
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut], animations: {
            self.label.center.x += self.www.bounds.width
            self.www.layoutIfNeeded()
        }, completion: nil)
}
}

