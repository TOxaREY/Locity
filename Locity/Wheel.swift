//
//  Wheel.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 08/04/2019.
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
        wheel.size = CGSize(width: 9 * (scene.frame.maxX - scene.frame.minX) / 10, height: 9 * (scene.frame.maxX - scene.frame.minX) / 10)
        UserDefaults.standard.set(wheel.size.height, forKey: "wheelSize")
        wheel.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: (scene.frame.maxY - scene.frame.minY) / 2)
        wheel.zRotation = 0
        NotificationCenter.default.addObserver(self, selector: #selector(addWheel), name: NSNotification.Name(rawValue: "addWheel"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(spinWheel), name: NSNotification.Name(rawValue: "spinWheel"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeWheel), name: NSNotification.Name(rawValue: "removeWheel"), object: nil)
        
    }
////Duration for anchor down
    func duration (random:Double) -> (Double) {
        let a = 42.28 * pow(random * 10, 0.15) / 10
        return a
    }
////

    
    @objc func addWheel(){
        scene!.addChild(wheel)
    }
    
    @objc func spinWheel(){
        scene!.removeAllChildren()
        let body = SKPhysicsBody(circleOfRadius: 9 * (scene!.frame.maxX - scene!.frame.minX) / 20)
        func randomFunc(){
            let random = CGFloat.random(in: 4.43 ... 60.72)
            if (random >= 7.94 && random <= 8.83) || (random >= 16.73 && random <= 17.62) || (random >= 21.13 && random <= 22.02) || (random >= 25.53 && random <= 26.42) || (random >= 34.33 && random <= 35.22) || (random >= 43.12 && random <= 44.01) || (random >= 51.92 && random <= 52.81) || (random >= 56.32 && random <= 57.21) {
                randomFunc()
            } else {
                UserDefaults.standard.set(duration(random: Double(random)), forKey: "randomWheel")
                body.angularVelocity = -random
                body.angularDamping = 0.7
                wheel.physicsBody = body
                scene!.addChild(wheel)
                
                timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.stopWheel), userInfo: nil, repeats: true)
            }
        }
        
        randomFunc()
    }
    
    @objc func stopWheel(){
        if (wheel.physicsBody!.isResting) {
            timer.invalidate()
            switch wheel.zRotation {
            case ((-segment)..<0): UserDefaults.standard.set(5, forKey: "resultContinent")
            case ((-2 * segment)..<(-segment)): UserDefaults.standard.set(4, forKey: "resultContinent")
            case (-π..<(-2 * segment)): UserDefaults.standard.set(3, forKey: "resultContinent")
            case ((2 * segment)..<π): UserDefaults.standard.set(3, forKey: "resultContinent")
            case (segment..<(2 * segment)): UserDefaults.standard.set(2, forKey: "resultContinent")
            case (0..<segment): UserDefaults.standard.set(1, forKey: "resultContinent")
            default: break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resultContinent"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upAnchor"), object: nil)
        }
    }
    @objc func removeWheel(){
        scene!.removeAllChildren()
        scene!.physicsWorld.gravity = CGVector.init(dx: 0, dy: -2)
        let body = SKPhysicsBody(circleOfRadius: 9 * (scene!.frame.maxX - scene!.frame.minX) / 20)
        body.angularVelocity = 100
        wheel.physicsBody = body
        scene!.addChild(wheel)
        var x = CGFloat()
        switch screenHeight {
        case 568:
            x = 700
        case 667:
            x = 1000
        case 736,812:
            x = 1300
        case 896:
            x = 1600
        default:
            x = 1000
        }
        body.applyImpulse(CGVector(dx: 0.0, dy: x))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "breakdown"), object: nil)
        }
    }
}

