//
//  Anchor.swift
//  Flip
//
//  Created by REYNIKOV ANTON on 02/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class Anchor: SKView {
    let anchor = SKSpriteNode(imageNamed: "anchor.png")
    override func didMoveToSuperview() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        let scene = SKScene(size: self.frame.size)
        print(scene)
        let edge = SKNode()
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: -0.05)
        self.presentScene(scene)
        self.allowsTransparency = true
        self.anchor.size = CGSize(width: scene.frame.width , height: scene.frame.height)
        self.anchor.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: scene.frame.maxY + (scene.frame.maxY - scene.frame.minY) / 2)
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: 0), to: CGPoint(x: scene.frame.maxX, y: 0))
        phyEdge.restitution = 0.0
        edge.physicsBody = phyEdge
        scene.addChild(edge)
        let body = SKPhysicsBody(rectangleOf: self.anchor.size)
        body.restitution = 0.35
        self.anchor.physicsBody = body
        NotificationCenter.default.addObserver(self, selector: #selector(self.down), name: NSNotification.Name(rawValue: "down"), object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(up), name: NSNotification.Name(rawValue: "up"), object: nil)
     }
    }
    
    @objc func down(){
        scene!.addChild(anchor)
    }

//    @objc func up(){
//        scene!.removeAllChildren()
//        scene!.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 1.85)
//        let edge2 = SKNode()
//        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: 2 * (scene!.frame.maxY)), to: CGPoint(x: scene!.frame.maxX, y: 2 * (scene!.frame.maxY)))
//        phyEdge.restitution = 0.0
//        edge2.physicsBody = phyEdge
//        scene!.addChild(edge2)
//        let body = SKPhysicsBody(rectangleOf: chain.size)
//        body.restitution = 0.0
//        chain.physicsBody = body
//        scene!.addChild(chain)
//    }
}

