//
//  Letter.swift
//  Letter
//
//  Created by REYNIKOV ANTON on 16/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit


class Letter: SKView {
    let letter = SKSpriteNode(imageNamed: "Y.png")
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        scene.physicsWorld.gravity = CGVector.zero
        self.presentScene(scene)
        self.allowsTransparency = true
        letter.size = self.frame.size
        letter.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: (scene.frame.maxY - scene.frame.minY) / 2)


        let body = SKPhysicsBody(rectangleOf: letter.size)

        body
        letter.physicsBody = body
        scene.addChild(letter)

    }

}
