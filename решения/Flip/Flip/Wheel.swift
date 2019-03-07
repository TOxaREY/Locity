///
//  Wheel.swift
//  Wheel
//
//  Created by REYNIKOV ANTON on 05/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

let π = CGFloat(Double.pi)

class Wheel: SKView {
    let wheel = SKSpriteNode(imageNamed: "wheel.png")
    var timer: Timer!
    let segment = ((360 / 5) * π) / 180
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.zero
        self.presentScene(scene)
        self.allowsTransparency = true
        wheel.size = CGSize(width: 9 * UIScreen.main.bounds.width / 10, height: 9 * UIScreen.main.bounds.width / 10)
        wheel.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: (scene.frame.maxY - scene.frame.minY) / 2)
        wheel.zRotation = 0
        NotificationCenter.default.addObserver(self, selector: #selector(addWheel), name: NSNotification.Name(rawValue: "addWheel"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(spin), name: NSNotification.Name(rawValue: "spin"), object: nil)
    }
    @objc func addWheel(){
        scene!.addChild(wheel)
    }
    @objc func spin(){
        scene!.removeAllChildren()
        let body = SKPhysicsBody(circleOfRadius: 9 * UIScreen.main.bounds.width / 20)
        let random = CGFloat.random(in: 5 ... 50)
        let random2 = CGFloat.random(in: 0.65 ... 0.75)
        body.angularVelocity = -random
        body.angularDamping = random2
        wheel.physicsBody = body
        scene!.addChild(wheel)
        
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.stopWheel), userInfo: nil, repeats: true)
    }
    @objc func stopWheel(){
        if (wheel.physicsBody!.isResting) {
            timer.invalidate()
            switch wheel.zRotation {
            case ((-segment)..<0): UserDefaults.standard.set("5", forKey: "Result")
            case ((-2 * segment)..<(-segment)): UserDefaults.standard.set("4", forKey: "Result")
            case (-π..<(-2 * segment)): UserDefaults.standard.set("3", forKey: "Result")
            case ((2 * segment)..<π): UserDefaults.standard.set("3", forKey: "Result")
            case (segment..<(2 * segment)): UserDefaults.standard.set("2", forKey: "Result")
            case (0..<segment): UserDefaults.standard.set("1", forKey: "Result")
            default: UserDefaults.standard.set("X", forKey: "Result")
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "res"), object: nil)
        }
    }
}

