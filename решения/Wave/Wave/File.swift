//
//  File.swift
//  Wave
//
//  Created by REYNIKOV ANTON on 09/05/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

let π = CGFloat(Double.pi)
extension SKAction {
    static func oscillation(amplitude a: CGFloat, timePeriod t: CGFloat, midPoint: CGPoint) -> SKAction {
        let action = SKAction.customAction(withDuration: Double(t)) { node, currentTime in
            let displacement = a * sin(2 * π * currentTime / t)
            node.position.y = midPoint.y + displacement
        }
        
        return action
    }
}

class Wave: SKView {
    let wave = SKSpriteNode(imageNamed: "w1.png")
    let wave2 = SKSpriteNode(imageNamed: "w2.png")
    let ship = SKSpriteNode(imageNamed: "ship2.png")
    let moon = SKSpriteNode(imageNamed: "moon.png")
    
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .darkGray
        self.presentScene(scene)
        self.allowsTransparency = true
        self.wave.size = CGSize(width: scene.frame.width * 2, height: scene.frame.height)
        self.wave.position = CGPoint(x: wave.size.width / 2, y: scene.frame.height / 2)
        self.wave.zPosition = 2
        self.wave2.size = CGSize(width: scene.frame.width * 2.5, height: scene.frame.height)
        self.wave2.position = CGPoint(x: -wave2.size.width / 2 + scene.frame.width, y: scene.frame.height / 2)
        self.wave.zPosition = 0
        self.ship.size = CGSize(width: (scene.frame.height / 1.25) * 0.88, height: scene.frame.height / 1.25)
        self.ship.position = CGPoint(x: -ship.size.width / 2, y: scene.frame.height / 1.9)
        self.ship.zRotation = 0.15
        self.wave.zPosition = 1
        
        
        self.moon.size = CGSize(width: scene.frame.height / 3.5, height: scene.frame.height / 3.5)
        self.moon.position = CGPoint(x: scene.frame.width - moon.size.width / 2, y: scene.frame.height / 3.2)
        scene.addChild(moon)
//        scene.addChild(wave)
//        scene.addChild(wave2)
//        scene.addChild(ship)
        let moveRight = SKAction.moveBy(x: wave2.size.width / 2, y: 0, duration: 10.0)
        let moveLeft = SKAction.moveBy(x: -wave.size.width / 2, y: 0, duration: 10.0)
        let moveShip = SKAction.moveBy(x: scene.frame.width + ship.size.width, y: 0, duration: 10.0)
        let moveMoon = SKAction.moveBy(x: -scene.frame.width + moon.size.width, y: 0, duration: 10.0)
        let oscillate = SKAction.oscillation(amplitude: 3, timePeriod: 2, midPoint: ship.position)
        let oscillate2 = SKAction.oscillation(amplitude: 30, timePeriod: 20, midPoint: moon.position)
        let rotation1 = SKAction.rotate(byAngle: -0.15, duration: 0.5)
        let rotation2 = SKAction.rotate(byAngle: -0.15, duration: 0.5)
        let rotation3 = SKAction.rotate(byAngle: 0.15, duration: 0.5)
        let rotation4 = SKAction.rotate(byAngle: 0.15, duration: 0.5)
        let seq = SKAction.sequence([rotation1, rotation2, rotation3, rotation4])
        let loop = SKAction.repeatForever(seq)
        let moveBottom = SKAction.moveBy(x: 0, y: -scene.frame.height / 2, duration: 1.0)
//        wave.run(moveLeft, completion: {scene.backgroundColor = .clear; self.wave.run(moveBottom); self.wave2.run(moveBottom, completion: {scene.removeAllChildren()})})
//        wave2.run(moveRight)
//        ship.run(moveShip)
//        ship.run(SKAction.repeatForever(oscillate))
//        ship.run(loop)
        moon.run(moveMoon)
        moon.run(oscillate2)
    }
}

