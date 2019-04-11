//
//  ViewController.swift
//  Label up
//
//  Created by REYNIKOV ANTON on 06/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        var bounds = label.bounds
//        label.font = label.font.withSize(40)
//        bounds.size = label.intrinsicContentSize
//        label.bounds = bounds
//        label.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//        UIView.animate(withDuration: 3.0) {
//            self.label.transform = .identity
//        }
       // var bounds = label.bounds
       // label.font = label.font.withSize(40)
        //bounds.size = label.intrinsicContentSize
        //label.bounds = bounds
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 5.0, animations: {
                self.label.transform = CGAffineTransform(translationX: 210, y: 0)
            }, completion: { done in
            self.label.transform = .identity
        })
        }

    }
}

