//
//  ViewController.swift
//  Wheel
//
//  Created by REYNIKOV ANTON on 04/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import SpriteKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        let view = SKView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view = view
        let wheel = SKSpriteNode(imageNamed: "wheel.png")
        let scene = SKScene(size: view.frame.size)
        scene.physicsWorld.gravity = CGVector.zero
        wheel.size = CGSize(width: 9 * UIScreen.main.bounds.width / 10, height: 9 * UIScreen.main.bounds.width / 10)
        wheel.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: (scene.frame.maxY - scene.frame.minY) / 2)
        let body = SKPhysicsBody(circleOfRadius: 9 * UIScreen.main.bounds.width / 20)
        body.angularVelocity = 18
        body.angularDamping = 0.75
        wheel.physicsBody = body
        scene.addChild(wheel)
        view.presentScene(scene)
    }
}

