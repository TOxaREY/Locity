//
//  FlipUp.swift
//  Flip

//  Created by REYNIKOV ANTON on 05/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class FlipUp: SKView {
    let flip = SKSpriteNode(imageNamed: "flip.png")
    var timer: Timer!
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        let edge = SKNode()
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: -1.85)
        self.presentScene(scene)
        self.allowsTransparency = true
        flip.size = CGSize(width: scene.frame.maxX, height: scene.frame.maxY + 4)
        flip.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: scene.frame.maxY + (scene.frame.maxY - scene.frame.minY) / 2)
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: -4), to: CGPoint(x: scene.frame.maxX, y: -4))
        edge.physicsBody = phyEdge
        scene.addChild(edge)
        let body = SKPhysicsBody(rectangleOf: flip.size)
        body.restitution = 0.35
        flip.physicsBody = body
        scene.addChild(flip)
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.resting), userInfo: nil, repeats: true)
        NotificationCenter.default.addObserver(self, selector: #selector(upFlip), name: NSNotification.Name(rawValue: "upFlip"), object: nil)
    }
    @objc func resting(){
        if (flip.physicsBody!.isResting) {
            timer.invalidate()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resting"), object: nil)
        }
    }
    @objc func upFlip(){
        print(flip.size)
        print(flip.position)
        
    }
}
