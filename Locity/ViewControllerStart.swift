//
//  ViewControllerStart.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 20/02/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit

class ViewControllerStart: UIViewController {
    
////View flip pic to start
    @IBOutlet weak var viewL: UIImageView!
    @IBOutlet weak var viewO: UIImageView!
    @IBOutlet weak var viewBluePin: UIImageView!
    @IBOutlet weak var viewRedPin: UIImageView!
    @IBOutlet weak var viewC: UIImageView!
    @IBOutlet weak var viewI: UIImageView!
    @IBOutlet weak var viewT: UIImageView!
    @IBOutlet weak var viewY: UIImageView!
    @IBOutlet weak var viewGreenPin: UIImageView!
////
////Function fliping letter
    func flip(viewName:UIImageView,picName:String) {
        viewName.image = UIImage(named: picName)
        UIView.transition(with: viewName, duration: 2.0, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
////Function fliping all letters recursion
    func allFlip(){
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
        self.flip(viewName: self.viewL, picName: "L")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.flip(viewName: self.viewO, picName: "O")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.flip(viewName: self.viewBluePin, picName: "bluePin")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.flip(viewName: self.viewRedPin, picName: "redPin")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.flip(viewName: self.viewC, picName: "C")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.flip(viewName: self.viewI, picName: "I")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.flip(viewName: self.viewT, picName: "T")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.flip(viewName: self.viewY, picName: "Y")
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.flip(viewName: self.viewGreenPin, picName: "greenPin")
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            self.allFlip()
                                        }
                                    }
                                }
                            }
                         }
                     }
                }
            }
        }
    }
    }

    override func viewDidLoad() {
        super.viewDidLoad()        
      allFlip()
  }
}



