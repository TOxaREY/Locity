//
//  CatalogStart.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 30/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//


import Foundation
import SpriteKit

let π = CGFloat(Double.pi)

class CatalogStart: SKView {
    let catalogStart = SKSpriteNode(imageNamed: "catalogStart.png")
    var rotationNode = CGFloat()
    deinit {
        print("deinitSKVCatalogStartVCS")
    }
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        self.presentScene(scene)
        self.allowsTransparency = true
        self.catalogStart.size = CGSize(width: scene.frame.height , height: scene.frame.height)
        self.catalogStart.position = CGPoint(x: -scene.frame.height, y: scene.frame.height / 2)
        rotationNode = (scene.frame.width + scene.frame.height / 2) / (scene.frame.height * π)
        self.catalogStart.zRotation = -2 * π * (1 - rotationNode.truncatingRemainder(dividingBy: 1))
        scene.addChild(catalogStart)
        NotificationCenter.default.addObserver(self, selector: #selector(self.moveCatalogStart), name: NSNotification.Name(rawValue: "moveCatalogStart"), object: nil)
    }
    
    @objc func moveCatalogStart(){
        let moveRight = SKAction.moveBy(x: scene!.frame.width + scene!.frame.height / 2, y: 0, duration: 1.5)
        let moveRotation = SKAction.rotate(byAngle: -2 * π * rotationNode, duration: 1.5)
        let pulseUp = SKAction.scale(to: 0.75, duration: 0.75)
        let pulseDown = SKAction.scale(to: 1, duration: 0.75)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        let seq = SKAction.sequence([moveRight,repeatPulse])
        catalogStart.run(seq)
        catalogStart.run(moveRotation)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "moveArrowStart"), object: nil)
    }
}

