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
    let flapB2 = SKSpriteNode(imageNamed: "flapB2.png")
    var flap = SKSpriteNode()
    var timer: Timer!
    deinit {
        print("deinitSKVFTVCC")
        deinitSKVFTVCC = true
    }
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        let edge = SKNode()
        if diff == "E"{
            flap = flapB2
        } else {
            flap = flapT
        }
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: -3.85)
        self.presentScene(scene)
        self.allowsTransparency = true
        flap.size = CGSize(width: scene.frame.maxX, height: scene.frame.maxY + 4)
        flap.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: scene.frame.maxY + (scene.frame.maxY - scene.frame.minY) / 2)
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: -4), to: CGPoint(x: scene.frame.maxX, y: -4))
        phyEdge.restitution = 0.0
        edge.physicsBody = phyEdge
        scene.addChild(edge)
        let body = SKPhysicsBody(rectangleOf: flap.size)
        body.restitution = 0.35
        flap.physicsBody = body
        if round == 1 {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            scene.addChild(self.flap)
            self.timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.restingDown), userInfo: nil, repeats: true)
            NotificationCenter.default.addObserver(self, selector: #selector(self.upFlap), name: NSNotification.Name(rawValue: "upFlap"), object: nil)
        }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                scene.addChild(self.flap)
                self.timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.restingDown2), userInfo: nil, repeats: true)
                NotificationCenter.default.addObserver(self, selector: #selector(self.upFlap), name: NSNotification.Name(rawValue: "upFlap"), object: nil)
            }
        }
    }
    @objc func restingDown(){
        if (flap.physicsBody!.isResting) {
            timer.invalidate()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableButtonFlap"), object: nil)
        }
    }
    @objc func restingDown2(){
        if (flap.physicsBody!.isResting) {
            timer.invalidate()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableAddStartElement"), object: nil)
        }
    }
    @objc func restingUp(){
        if (flap.physicsBody!.isResting) {
            timer.invalidate()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableSpinButton"), object: nil)
        }
    }
    @objc func upFlap(){
        scene!.removeAllChildren()
        scene!.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 3.85)
        let edge2 = SKNode()
        let phyEdge = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: 2 * (scene!.frame.maxY + 4)), to: CGPoint(x: scene!.frame.maxX, y: 2 * (scene!.frame.maxY + 4)))
        phyEdge.restitution = 0.0
        edge2.physicsBody = phyEdge
        scene!.addChild(edge2)
        let body = SKPhysicsBody(rectangleOf: flap.size)
        body.restitution = 0.0
        flap.physicsBody = body
        scene!.addChild(flap)
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.restingUp), userInfo: nil, repeats: true)

    }
}

