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
    let flapT2 = SKSpriteNode(imageNamed: "flapT2.png")
    var flap = SKSpriteNode()
    deinit {
        print("dFB")
    }
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        let edge = SKNode()
        if diff == "H"{
            flap = flapT2
        } else {
            flap = flapB
        }
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 3.85)
        self.presentScene(scene)
        self.allowsTransparency = true
        flap.size = CGSize(width: scene.frame.maxX, height: scene.frame.maxY + 4)
        flap.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: -((scene.frame.maxY - scene.frame.minY) / 2))
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: scene.frame.maxY + 4), to: CGPoint(x: scene.frame.maxX, y: scene.frame.maxY + 4))
        phyEdge.restitution = 0.0
        edge.physicsBody = phyEdge
        scene.addChild(edge)
        let body = SKPhysicsBody(rectangleOf: flap.size)
        body.restitution = 0.35
        flap.physicsBody = body
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            scene.addChild(self.flap)
            NotificationCenter.default.addObserver(self, selector: #selector(self.downFlap), name: NSNotification.Name(rawValue: "downFlap"), object: nil)
        }
    }
    @objc func downFlap(){
        scene!.removeAllChildren()
        scene!.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: -3.85)
        let edge2 = SKNode()
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: -(scene!.frame.maxY + 8)), to: CGPoint(x: scene!.frame.maxX, y: -(scene!.frame.maxY + 8)))
        phyEdge.restitution = 0.0
        edge2.physicsBody = phyEdge
        scene!.addChild(edge2)
        let body = SKPhysicsBody(rectangleOf: flap.size)
        body.restitution = 0.0
        flap.physicsBody = body
        scene!.addChild(flap)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "downFlap"), object: nil)
    }
}

