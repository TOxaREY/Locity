//
//  ViewController.swift
//  letter&data
//
//  Created by REYNIKOV ANTON on 21/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var i = 0
    var rand = 0
    @IBOutlet weak var label: UILabel!
    @IBAction func button(_ sender: Any) {
        i = 0
        rand = 0
        printi(arr: array)
    }
    
    var array = [1:"aq",2:"df",3:"gh",4:"se",5:"jh",6:"sp",7:"ff",8:"lj",9:"sd",10:"ns",11:"mo",12:"ws",13:"pp"]
    
    func printi(arr:Dictionary<Int, String>){
        let random = Int.random(in: 1...13)
        if rand == random {
            printi(arr: arr)
        } else {
            rand = random
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.label.text = arr[random]!
                self.i += 1
                if self.i != 20 {
                    self.printi(arr: arr)
                }
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
