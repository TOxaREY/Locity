//
//  ViewControllerStart.swift
//  Locity
//tr
//  Created by REYNIKOV ANTON on 20/02/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import Foundation


class ViewControllerStart: UIViewController {
    

    var vcActiv = true
    
    
    @IBAction func butCatalog(_ sender: Any) {
        vcActiv = false
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = sB.instantiateViewController(withIdentifier: "VCCat")
        appDel.window?.rootViewController = newVC
        appDel.window?.makeKeyAndVisible()
    }

    @IBOutlet weak var butCatalog: UIButton!
    @IBOutlet weak var but: UIButton!
    @IBAction func but(_ sender: Any) {
        vcActiv = false
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = sB.instantiateViewController(withIdentifier: "VCC")
        appDel.window?.rootViewController = newVC
        appDel.window?.makeKeyAndVisible()
    }
    

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
DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "moveArrowStart"), object: nil)
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "moveCatalogStart"), object: nil)
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
        if vcActiv{
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
}
////
////Enable button countinue
    @objc func enableButton(){
        self.but.isEnabled = true
        self.butCatalog.isEnabled = true
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "enableButton"), object: nil)
    }
////
    deinit {
        print("deinitVCS")
        deinitVCS = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        but.isEnabled = false
        butCatalog.isEnabled = false
        allFlip(time: 0.25)
        allFlipUpDown(time: 0.125)
        NotificationCenter.default.addObserver(self, selector: #selector(enableButton), name: NSNotification.Name(rawValue: "enableButton"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
}


