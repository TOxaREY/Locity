//
//  Map.swift
//  Map
//
//  Created by REYNIKOV ANTON on 28/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class Map: SKView {
    let ring = SKSpriteNode(imageNamed: "ring.png")
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        self.presentScene(scene)
        self.allowsTransparency = true
        let delta = ((scene.frame.maxY - scene.frame.minY) - ((scene.frame.maxX - scene.frame.minX) * 1.4621578)) / 2
        ring.size = CGSize(width: (scene.frame.maxX - scene.frame.minX) * 0.02415458937, height: (scene.frame.maxX - scene.frame.minX) * 0.02415458937)
        ring.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 1.037594, y: (((scene.frame.maxY - delta) - (scene.frame.minY + delta)) / 1.558798) + delta)
        print(delta)
        scene.addChild(ring)
    }
}
