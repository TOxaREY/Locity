//
//  ViewControllerStart.swift
//  Locity
//tr
//  Created by REYNIKOV ANTON on 20/02/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import Foundation

////Pulsate label
extension UILabel {
    func pulsate() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.65
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = .greatestFiniteMagnitude
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(pulse, forKey: nil)
    }
}
////
//// Determination of height device
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}
////
class ViewControllerStart: UIViewController {
    
    @IBOutlet weak var but: UIButton!
    @IBOutlet weak var contiLabel: UILabel!
    
////Function enable pulsate
    func enableLabelButton() {
        but.isEnabled = true
        contiLabel.isHidden = false
        contiLabel.pulsate()
    }
////
////View flip centre pic to start
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
////View flip up pic to start
    @IBOutlet weak var viewUpT: UIImageView!
    @IBOutlet weak var viewUpH: UIImageView!
    @IBOutlet weak var viewUpE: UIImageView!
    @IBOutlet weak var viewUp_: UIImageView!
    @IBOutlet weak var viewUpL: UIImageView!
    @IBOutlet weak var viewUpO: UIImageView!
    @IBOutlet weak var viewUpC: UIImageView!
    @IBOutlet weak var viewUpA: UIImageView!
    @IBOutlet weak var viewUpT2: UIImageView!
    @IBOutlet weak var viewUpI: UIImageView!
    @IBOutlet weak var viewUpO2: UIImageView!
    @IBOutlet weak var viewUpN: UIImageView!
////
////View flip down pic to start
    @IBOutlet weak var viewDownO: UIImageView!
//// Position viewDownO
    func constraintViewDownO() {
        viewDownO.translatesAutoresizingMaskIntoConstraints = false
        switch screenHeight {
        case 736: viewDownO.topAnchor.constraint(equalTo: viewDownO.superview!.topAnchor, constant: 53.33).isActive = true
        case 812: viewDownO.topAnchor.constraint(equalTo: viewDownO.superview!.topAnchor, constant: 71.67).isActive = true
        case 896: viewDownO.topAnchor.constraint(equalTo: viewDownO.superview!.topAnchor, constant: 81.5).isActive = true
        case 667: viewDownO.topAnchor.constraint(equalTo: viewDownO.superview!.topAnchor, constant: 47.5).isActive = true
        case 568: viewDownO.topAnchor.constraint(equalTo: viewDownO.superview!.topAnchor, constant: 38.5).isActive = true
        case 480: viewDownO.topAnchor.constraint(equalTo: viewDownO.superview!.topAnchor, constant: 16.5).isActive = true
        default: viewDownO.topAnchor.constraint(equalTo: viewDownO.superview!.topAnchor, constant: 47.5).isActive = true
        }
    }
////
    @IBOutlet weak var viewDownF: UIImageView!
    @IBOutlet weak var viewDown_: UIImageView!
    @IBOutlet weak var viewDownT: UIImageView!
    @IBOutlet weak var viewDownH: UIImageView!
    @IBOutlet weak var viewDownE: UIImageView!
    @IBOutlet weak var viewDown_2: UIImageView!
    @IBOutlet weak var viewDownC: UIImageView!
    @IBOutlet weak var viewDownI: UIImageView!
    @IBOutlet weak var viewDownT2: UIImageView!
    @IBOutlet weak var viewDownY: UIImageView!
    @IBOutlet weak var viewDownRose: UIImageView!
////
////Function fliping up & down letter
    func flipUpDown(viewName:UIImageView,picName:String) {
        viewName.image = UIImage(named: picName)
        UIView.transition(with: viewName, duration: 1.0, options: .transitionCurlDown, animations: nil, completion: nil)
    }
////
////Function fliping up & down all letters
    func allFlipUpDown(time:Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.flipUpDown(viewName: self.viewUpT, picName: "T")
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.flipUpDown(viewName: self.viewUpH, picName: "H")
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    self.flipUpDown(viewName: self.viewUpE, picName: "E")
                    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                        self.flipUpDown(viewName: self.viewUp_, picName: "_")
                        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                            self.flipUpDown(viewName: self.viewUpL, picName: "L")
                            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                self.flipUpDown(viewName: self.viewUpO, picName: "O")
                                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                    self.flipUpDown(viewName: self.viewUpC, picName: "C")
                                    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                        self.flipUpDown(viewName: self.viewUpA, picName: "A")
                                        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                            self.flipUpDown(viewName: self.viewUpT2, picName: "T")
                                            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                                self.flipUpDown(viewName: self.viewUpI, picName: "I")
                                                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                                    self.flipUpDown(viewName: self.viewUpO2, picName: "O")
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                                        self.flipUpDown(viewName: self.viewUpN, picName: "N")
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                                        self.flipUpDown(viewName: self.viewDownO, picName: "O")
                                                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                                    self.flipUpDown(viewName: self.viewDownF, picName: "F")
                                            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                                self.flipUpDown(viewName: self.viewDown_, picName: "_")
                                     DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                         self.flipUpDown(viewName: self.viewDownT, picName: "T")
                                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                    self.flipUpDown(viewName: self.viewDownH, picName: "H")
                            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                self.flipUpDown(viewName: self.viewDownE, picName: "E")
                        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                            self.flipUpDown(viewName: self.viewDown_2, picName: "_")
                    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                        self.flipUpDown(viewName: self.viewDownC, picName: "C")
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    self.flipUpDown(viewName: self.viewDownI, picName: "I")
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.flipUpDown(viewName: self.viewDownT2, picName: "T")
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.flipUpDown(viewName: self.viewDownY, picName: "Y")
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        self.flipUpDown(viewName: self.viewDownRose, picName: "compass")
        self.enableLabelButton()
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
            }
        }
    }
////
////Function fliping center letter
    func flip(viewName:UIImageView,picName:String) {
        viewName.image = UIImage(named: picName)
        UIView.transition(with: viewName, duration: 2.0, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
////
////Function fliping center all letters recursion
    func allFlip(time:Double){
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.flip(viewName: self.viewL, picName: "L")
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.flip(viewName: self.viewO, picName: "O")
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.flip(viewName: self.viewBluePin, picName: "bluePin")
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    self.flip(viewName: self.viewRedPin, picName: "redPin")
                    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                        self.flip(viewName: self.viewC, picName: "C")
                        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                            self.flip(viewName: self.viewI, picName: "I")
                            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                self.flip(viewName: self.viewT, picName: "T")
                                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                    self.flip(viewName: self.viewY, picName: "Y")
                                    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                                        self.flip(viewName: self.viewGreenPin, picName: "greenPin")
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            self.allFlip(time: time)
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
////
    override func viewDidLoad() {
        super.viewDidLoad()
        print(screenHeight)
        constraintViewDownO()
        but.isEnabled = false
        contiLabel.isHidden = true
        allFlip(time: 0.25)
        allFlipUpDown(time: 0.125)
  }
}



