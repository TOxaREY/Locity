//
//  Pen.swift
//  Pendulum
//
//  Created by REYNIKOV ANTON on 11/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class Pen: SKView {

    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: -5)
        self.presentScene(scene)
        self.allowsTransparency = true
        let nodeSize = CGSize(width: 1, height: 1)
        let node = SKSpriteNode(color: .clear, size: nodeSize)
        node.position = CGPoint(x: scene.frame.width / 2, y: scene.frame.height / 2)
        node.physicsBody = SKPhysicsBody(rectangleOf: nodeSize)
        node.physicsBody?.isDynamic = false
        scene.addChild(node)
        
        let node2Size = CGSize(width: 60, height: 8)
        let node2 = SKSpriteNode(color: .green, size: node2Size)
        node2.position = CGPoint(x: scene.frame.width / 2 + 30, y: scene.frame.height / 2)
        node2.physicsBody = SKPhysicsBody(rectangleOf: node2Size)
        scene.addChild(node2)


        let a = SKPhysicsJointPin.joint(withBodyA: node.physicsBody! , bodyB: node2.physicsBody!, anchor: CGPoint(x: scene.frame.width / 2, y: scene.frame.height / 2))
        scene.physicsWorld.add(a)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        scene.physicsWorld.removeAllJoints()
        }
        
        
    }
}
