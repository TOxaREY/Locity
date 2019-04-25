//
//  ViewController.swift
//  Label up
//
//  Created by REYNIKOV ANTON on 06/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    func makeDashedBorder(name:UILabel)  {
//        let mViewBorder = CAShapeLayer()
//        mViewBorder.strokeColor = UIColor.black.cgColor
//        mViewBorder.lineDashPattern = [10, 10]
//        mViewBorder.frame = name.bounds
//        mViewBorder.lineWidth = 3
//        mViewBorder.fillColor = nil
//        mViewBorder.path = UIBezierPath(rect: name.bounds).cgPath
//        name.layer.addSublayer(mViewBorder)
//    }
 
    var rand = 0
    var rand2 = 0
    var select = [1:"1",2:"2",3:"3",4:"4",5:"5",6:"6"]
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBAction func button(_ sender: Any) {
//    selectFunc(dic: select)
lab()
    }
//    func selectFunc(dic:Dictionary<Int, String>) {
//        let random = Int.random(in: 1...dic.count)
//        if rand == random || rand2 == random {
//            selectFunc(dic: dic)
//        } else {
//            if rand == 0 {
//                rand = random
//                print(dic[random]!)
//            } else {
//                if rand2 == 0 {
//                    rand2 = random
//                    print(dic[random]!)
//                } else {
//                    print(dic[random]!)
//                }
//            }
//        }
//    }
    func lab() {
    label1.transform = CGAffineTransform(scaleX: 0, y: 1)
    UIView.animate(withDuration: 3.0, animations: {
        self.label1.transform = .identity
    }, completion: { done in
    print("ddddddd")
    })
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        var bounds = label.bounds
//        label.font = label.font.withSize(40)
//        bounds.size = label.intrinsicContentSize
//        label.bounds = bounds
//        label.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
//
//        UIView.animate(withDuration: 3.0, animations: {
//            self.label.transform = .identity
//        }, completion: { done in
//            let transformSc = CGAffineTransform(scaleX: 0.5, y: 0.5)
//            let transformTr = CGAffineTransform(translationX: 0, y: 500)
//            UIView.animate(withDuration: 3.0, animations: {
//                self.label.transform = transformTr.concatenating(transformSc)
//            }, completion: { done in
//            print("ddd")
//
//        })
//    })
}
}
            
            
            

