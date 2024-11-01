//
//  Sign.swift
//  SQL
//
//  Created by REYNIKOV ANTON on 31/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class Sign: SKView {
    let chain = SKSpriteNode(imageNamed: "chain.png")
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        let edge = SKNode()
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: -1.85)
        self.presentScene(scene)
        self.allowsTransparency = true
        chain.size = CGSize(width: scene.frame.maxX, height: scene.frame.maxY)
        chain.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: scene.frame.maxY + (scene.frame.maxY - scene.frame.minY) / 2)
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: -4), to: CGPoint(x: scene.frame.maxX, y: -4))
        phyEdge.restitution = 0.0
        edge.physicsBody = phyEdge
        scene.addChild(edge)
        let body = SKPhysicsBody(rectangleOf: chain.size)
        body.restitution = 0.35
        chain.physicsBody = body
        NotificationCenter.default.addObserver(self, selector: #selector(down), name: NSNotification.Name(rawValue: "down"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(up), name: NSNotification.Name(rawValue: "up"), object: nil)
    }

    @objc func down(){
        scene!.addChild(chain)
    }
    @objc func up(){
        scene!.removeAllChildren()
        scene!.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 1.85)
        let edge2 = SKNode()
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: 2 * (scene!.frame.maxY + 4)), to: CGPoint(x: scene!.frame.maxX, y: 2 * (scene!.frame.maxY + 4)))
        phyEdge.restitution = 0.0
        edge2.physicsBody = phyEdge
        scene!.addChild(edge2)
        let body = SKPhysicsBody(rectangleOf: chain.size)
        body.restitution = 0.0
        chain.physicsBody = body
        scene!.addChild(chain)
    }
}

