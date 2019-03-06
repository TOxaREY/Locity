//
//  FlipDown.swift
//  Flip
//
//  Created by REYNIKOV ANTON on 05/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class FlipDown: SKView {
    let flip2 = SKSpriteNode(imageNamed: "flip2.png")
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        let edge = SKNode()
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 1.85)
        self.presentScene(scene)
        self.allowsTransparency = true
        flip2.size = CGSize(width: scene.frame.maxX, height: scene.frame.maxY + 4)
        flip2.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: -((scene.frame.maxY - scene.frame.minY) / 2))
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: scene.frame.maxY + 4), to: CGPoint(x: scene.frame.maxX, y: scene.frame.maxY + 4))
        edge.physicsBody = phyEdge
        scene.addChild(edge)
        let body = SKPhysicsBody(rectangleOf: flip2.size)
        body.restitution = 0.35
        flip2.physicsBody = body
        scene.addChild(flip2)
        NotificationCenter.default.addObserver(self, selector: #selector(upFlip), name: NSNotification.Name(rawValue: "upFlip"), object: nil)
    }
    @objc func upFlip(){
        
    }
}
