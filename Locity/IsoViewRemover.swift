//
//  IsoViewRemover.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 10/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class IsoViewRemover: SKView {
    let isoRem = SKSpriteNode(imageNamed: "isoRem.png")
    deinit {
        print("deinitSKVIsoViewRemoverVCC")
        deinitSKVIsoViewRemoverVCC = true
    }
    override func didMoveToSuperview() {
////Dispatch for loading view constraints
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let scene = SKScene(size: self.frame.size)
            scene.backgroundColor = .clear
            self.presentScene(scene)
            self.allowsTransparency = true
            let hSize = isoViewHeight
            self.isoRem.size = CGSize(width: hSize * 1.3, height: hSize)
            self.isoRem.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: hSize / 2)
            self.isoRem.zRotation = 0
            NotificationCenter.default.addObserver(self, selector: #selector(self.addIsoFrameRemover), name: NSNotification.Name(rawValue: "addIsoFrameRemover"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.breakdown), name: NSNotification.Name(rawValue: "breakdown"), object: nil)
        }
    }
    
    @objc func addIsoFrameRemover(){
        scene!.removeAllChildren()
        scene!.addChild(isoRem)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "addIsoFrameRemover"), object: nil)
    }
    @objc func breakdown(){
        scene!.removeAllChildren()
        scene!.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: -5)
        self.isoRem.physicsBody = SKPhysicsBody(rectangleOf: self.isoRem.size)
        scene!.addChild(isoRem)
        let pinSize = CGSize(width: 1, height: 1)
        let pin = SKSpriteNode(color: .clear, size: pinSize)
        pin.position = CGPoint(x: (scene!.frame.maxX - scene!.frame.minX) / 2  - isoRem.size.width / 2 + 10, y: isoRem.size.height - 10)
        pin.physicsBody = SKPhysicsBody(rectangleOf: pinSize)
        pin.physicsBody?.isDynamic = false
        scene!.addChild(pin)
        let a = SKPhysicsJointPin.joint(withBodyA: pin.physicsBody! , bodyB: isoRem.physicsBody!, anchor: CGPoint(x: (scene!.frame.maxX - scene!.frame.minX) / 2  - isoRem.size.width / 2 + 10, y: isoRem.size.height - 10))
        scene!.physicsWorld.add(a)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.scene!.physicsWorld.removeAllJoints()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.scene!.removeAllChildren()
        }
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "breakdown"), object: nil)
    }
}


