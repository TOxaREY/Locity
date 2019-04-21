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
        var bounds = label.bounds
        label.font = label.font.withSize(40)
        bounds.size = label.intrinsicContentSize
        label.bounds = bounds
        label.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)

        UIView.animate(withDuration: 3.0, animations: {
            self.label.transform = .identity
        }, completion: { done in
            let transformSc = CGAffineTransform(scaleX: 0.5, y: 0.5)
            let transformTr = CGAffineTransform(translationX: 0, y: 500)
            UIView.animate(withDuration: 3.0, animations: {
                self.label.transform = transformTr.concatenating(transformSc)
            }, completion: { done in
            print("ddd")

        })
    })
}
}
            
            
            

