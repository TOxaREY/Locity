//
//  Anchor.swift
//  Flip
//
//  Created by REYNIKOV ANTON on 02/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class Anchor: SKView {
    let anchor = SKSpriteNode(imageNamed: "anchor.png")
    var timer: Timer!
    override func didMoveToSuperview() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        let scene = SKScene(size: self.frame.size)
        print(scene)
        scene.backgroundColor = .clear
        self.presentScene(scene)
        self.allowsTransparency = true
        self.anchor.size = CGSize(width: scene.frame.width , height: scene.frame.height)
        self.anchor.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: scene.frame.maxY + (scene.frame.maxY - scene.frame.minY) / 2)
        NotificationCenter.default.addObserver(self, selector: #selector(self.down), name: NSNotification.Name(rawValue: "down"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.up), name: NSNotification.Name(rawValue: "up"), object: nil)
       }
    }
    @objc func down(){
        scene!.addChild(anchor)
        anchor.run(SKAction.moveBy(x: 0, y: -(scene!.frame.maxY - scene!.frame.minY), duration: UserDefaults.standard.double(forKey: "random")))
    }
    @objc func up(){
        anchor.run(SKAction.moveBy(x: 0, y: (scene!.frame.maxY - scene!.frame.minY), duration: 2))
    
  }
}
