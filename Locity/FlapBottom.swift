//
//  FlapBottom.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 08/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class FlapBottom: SKView {
    let flapB = SKSpriteNode(imageNamed: "flapB.png")
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        let edge = SKNode()
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 1.85)
        self.presentScene(scene)
        self.allowsTransparency = true
        flapB.size = CGSize(width: scene.frame.maxX, height: scene.frame.maxY + 4)
        flapB.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: -((scene.frame.maxY - scene.frame.minY) / 2))
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: scene.frame.maxY + 4), to: CGPoint(x: scene.frame.maxX, y: scene.frame.maxY + 4))
        phyEdge.restitution = 0.0
        edge.physicsBody = phyEdge
        scene.addChild(edge)
        let body = SKPhysicsBody(rectangleOf: flapB.size)
        body.restitution = 0.35
        flapB.physicsBody = body
        scene.addChild(flapB)
        NotificationCenter.default.addObserver(self, selector: #selector(downFlap), name: NSNotification.Name(rawValue: "upFlap"), object: nil)
    }
    @objc func downFlap(){
        scene!.removeAllChildren()
        scene!.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: -1.85)
        let edge2 = SKNode()
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: -(scene!.frame.maxY + 8)), to: CGPoint(x: scene!.frame.maxX, y: -(scene!.frame.maxY + 8)))
        phyEdge.restitution = 0.0
        edge2.physicsBody = phyEdge
        scene!.addChild(edge2)
        let body = SKPhysicsBody(rectangleOf: flapB.size)
        body.restitution = 0.0
        flapB.physicsBody = body
        scene!.addChild(flapB)
    }
}

