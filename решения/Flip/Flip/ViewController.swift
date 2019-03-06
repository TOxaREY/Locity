//
//  ViewController.swift
//  Flip
//
//  Created by REYNIKOV ANTON on 05/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBAction func upButtonPush(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlip"), object: nil)
    }
    @IBAction func downButtonPush(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlip"), object: nil)
    }
    @objc func enableButton(){
        upButton.isEnabled = true
        downButton.isEnabled = true
        upButton.isHidden = false
        downButton.isHidden = false
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        upButton.isEnabled = false
        downButton.isEnabled = false
        upButton.isHidden = true
        downButton.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(enableButton), name: NSNotification.Name(rawValue: "resting"), object: nil)
    }
}

