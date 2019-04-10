//
//  Remove.swift
//  remove
//
//  Created by REYNIKOV ANTON on 10/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class IsoViewRemover: SKView {
    let iso = SKSpriteNode(imageNamed: "iso.png")
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.zero
        self.presentScene(scene)
        self.allowsTransparency = true
        let hSize = CGFloat(130)
        iso.size = CGSize(width: hSize * 1.3, height: hSize)
        iso.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: hSize / 2)
        iso.zRotation = 0
        scene.addChild(iso)
    }
    
}

