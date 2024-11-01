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
        wheel.size = CGSize(width: 9 * (scene.frame.maxX - scene.frame.minX) / 10, height: 9 * (scene.frame.maxX - scene.frame.minX) / 10)
        UserDefaults.standard.set(wheel.size.height, forKey: "wheelSize")
        wheel.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: (scene.frame.maxY - scene.frame.minY) / 2)
        wheel.zRotation = 0
        NotificationCenter.default.addObserver(self, selector: #selector(addWheel), name: NSNotification.Name(rawValue: "addWheel"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(spin), name: NSNotification.Name(rawValue: "spin"), object: nil)
        
    }
    @objc func addWheel(){
        scene!.addChild(wheel)
    }
    
    func dur (r:Double) -> (Double) {
        let a = 42.28 * pow(r * 10, 0.15) / 10
        print(a)
        return a
    }
    
    @objc func spin(){
        scene!.removeAllChildren()
        let body = SKPhysicsBody(circleOfRadius: 9 * (scene!.frame.maxX - scene!.frame.minX) / 20)
        func randomFunc(){
        let random = CGFloat.random(in: 4.43 ... 60.72)
        if (random >= 7.94 && random <= 8.83) || (random >= 16.73 && random <= 17.62) || (random >= 21.13 && random <= 22.02) || (random >= 25.53 && random <= 26.42) || (random >= 34.33 && random <= 35.22) || (random >= 43.12 && random <= 44.01) || (random >= 51.92 && random <= 52.81) || (random >= 56.32 && random <= 57.21) {
            randomFunc()
        } else {
            UserDefaults.standard.set(dur(r: Double(random)), forKey: "random")
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
            case ((-segment)..<0): UserDefaults.standard.set("Qwertyf", forKey: "Result")
            case ((-2 * segment)..<(-segment)): UserDefaults.standard.set("Яблоко", forKey: "Result")
            case (-π..<(-2 * segment)): UserDefaults.standard.set("ßçëâêèéñ", forKey: "Result")
            case ((2 * segment)..<π): UserDefaults.standard.set("ßçëâêèéñ", forKey: "Result")
            case (segment..<(2 * segment)): UserDefaults.standard.set("Фьукшсф", forKey: "Result")
            case (0..<segment): UserDefaults.standard.set("Oceania", forKey: "Result")
            default: UserDefaults.standard.set("X", forKey: "Result")
            }

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "res"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "up"), object: nil)
        }
    }
}

