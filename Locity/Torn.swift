//
//  Torn.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 12/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import SpriteKit

class Torn: SKView {
    let t1 = SKSpriteNode(imageNamed: "t1.png")
    let t2 = SKTexture(imageNamed: "t2.png")
    let t3 = SKTexture(imageNamed: "t3.png")
    let t4 = SKTexture(imageNamed: "t4.png")
    let t5 = SKTexture(imageNamed: "t5.png")
    let t6 = SKTexture(imageNamed: "t6.png")
    let t7 = SKTexture(imageNamed: "t7.png")
    let t8 = SKTexture(imageNamed: "t8.png")
    let t9 = SKTexture(imageNamed: "t9.png")
    let t10 = SKTexture(imageNamed: "t10.png")
    let t11 = SKTexture(imageNamed: "t11.png")
    let t12 = SKTexture(imageNamed: "t12.png")
    let t13 = SKTexture(imageNamed: "t13.png")
    let t14 = SKTexture(imageNamed: "t14.png")
    let t15 = SKTexture(imageNamed: "t15.png")
    let t16 = SKTexture(imageNamed: "t16.png")
    let t17 = SKTexture(imageNamed: "t17.png")
    let t18 = SKTexture(imageNamed: "t18.png")
    let t19 = SKTexture(imageNamed: "t19.png")
    let t20 = SKTexture(imageNamed: "t20.png")
    let t21 = SKTexture(imageNamed: "t21.png")
    let t22 = SKTexture(imageNamed: "t22.png")
    let t23 = SKTexture(imageNamed: "t23.png")
    let t24 = SKTexture(imageNamed: "t24.png")
    let t25 = SKTexture(imageNamed: "t25.png")
    let t26 = SKTexture(imageNamed: "t26.png")
    let t27 = SKTexture(imageNamed: "t27.png")
    let t28 = SKTexture(imageNamed: "t28.png")
    let t29 = SKTexture(imageNamed: "t29.png")
    let t30 = SKTexture(imageNamed: "t30.png")
    let t31 = SKTexture(imageNamed: "t31.png")
    let t32 = SKTexture(imageNamed: "t32.png")
    let t33 = SKTexture(imageNamed: "t33.png")
    let t34 = SKTexture(imageNamed: "t34.png")
    let t35 = SKTexture(imageNamed: "t35.png")
    let t36 = SKTexture(imageNamed: "t36.png")
    deinit {
        print("deinitSKVTornVCM")
    }
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = UIColor.clear
        self.presentScene(scene)
        self.allowsTransparency = true
        self.backgroundColor = UIColor.clear
        t1.size = scene.frame.size
        t1.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        scene.addChild(t1)
        let animate = SKAction.animate(with: [t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t33,t34,t35,t36], timePerFrame: 0.025)
        t1.run(animate, completion: {NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableVCM"), object: nil)})
                
    }
}
