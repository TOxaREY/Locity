//
//  ViewController.swift
//  Flip
//
//  Created by REYNIKOV ANTON on 05/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var upFlip: UIImageView!
    
    func flipUpDown(viewName:UIImageView,picName:String) {
        viewName.image = UIImage(named: picName)
        UIView.transition(with: viewName, duration: 5.0, options: .transitionCurlUp, animations: nil, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flipUpDown(viewName: upFlip, picName: "flip")
        
        
        
    }


}

