//
//  FlapTop.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 08/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class FlapTop: SKView {
    let flapT = SKSpriteNode(imageNamed: "flapT.png")
    var timer: Timer!
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        let edge = SKNode()
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: -1.85)
        self.presentScene(scene)
        self.allowsTransparency = true
        flapT.size = CGSize(width: scene.frame.maxX, height: scene.frame.maxY + 4)
        flapT.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: scene.frame.maxY + (scene.frame.maxY - scene.frame.minY) / 2)
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: -4), to: CGPoint(x: scene.frame.maxX, y: -4))
        phyEdge.restitution = 0.0
        edge.physicsBody = phyEdge
        scene.addChild(edge)
        let body = SKPhysicsBody(rectangleOf: flapT.size)
        body.restitution = 0.35
        flapT.physicsBody = body
        scene.addChild(flapT)
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.restingDown), userInfo: nil, repeats: true)
        NotificationCenter.default.addObserver(self, selector: #selector(upFlap), name: NSNotification.Name(rawValue: "upFlap"), object: nil)
    }
    @objc func restingDown(){
        if (flapT.physicsBody!.isResting) {
            timer.invalidate()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "restingDown"), object: nil)
        }
    }
    @objc func restingUp(){
        if (flapT.physicsBody!.isResting) {
            timer.invalidate()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableSpinButton"), object: nil)
        }
    }
    @objc func upFlap(){
        scene!.removeAllChildren()
        scene!.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 1.85)
        let edge2 = SKNode()
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: 2 * (scene!.frame.maxY + 4)), to: CGPoint(x: scene!.frame.maxX, y: 2 * (scene!.frame.maxY + 4)))
        phyEdge.restitution = 0.0
        edge2.physicsBody = phyEdge
        scene!.addChild(edge2)
        let body = SKPhysicsBody(rectangleOf: flapT.size)
        body.restitution = 0.0
        flapT.physicsBody = body
        scene!.addChild(flapT)
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.restingUp), userInfo: nil, repeats: true)
    }
}

