//
//  ArrowStart.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 06/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class ArrowStart: SKView {
    let arrowStart = SKSpriteNode(imageNamed: "arrowStart.png")
    deinit {
        print("dS")
    }
    override func didMoveToSuperview() {
            let scene = SKScene(size: self.frame.size)
            scene.backgroundColor = .clear
            self.presentScene(scene)
            self.allowsTransparency = true
            self.arrowStart.size = CGSize(width: scene.frame.height , height: scene.frame.height)
            self.arrowStart.position = CGPoint(x: -scene.frame.height, y: scene.frame.height / 2)
            scene.addChild(arrowStart)
            NotificationCenter.default.addObserver(self, selector: #selector(self.moveArrowStart), name: NSNotification.Name(rawValue: "moveArrowStart"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableButton"), object: nil)
        }

    @objc func moveArrowStart(){
        let moveRight = SKAction.moveBy(x: scene!.frame.width + scene!.frame.height / 2, y: 0, duration: 1.5)
        let pulseUp = SKAction.scale(to: 0.75, duration: 1)
        let pulseDown = SKAction.scale(to: 1, duration: 1)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        let seq = SKAction.sequence([moveRight,repeatPulse])
        arrowStart.run(seq)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableButton"), object: nil)
    }
  }
}

