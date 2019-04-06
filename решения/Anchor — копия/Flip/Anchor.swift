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
    var dur: CGFloat = 0.0
    override func didMoveToSuperview() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                switch UIScreen.main.bounds.height {
                case 896:
                    self.dur = 52
                case 812:
                    self.dur = 47
                case 736:
                    self.dur = 40
                case 667:
                    self.dur = 37
                case 568:
                    self.dur = 31
                default:
                    self.dur = 37
                }
            print(self.dur)
            print(UIScreen.main.bounds.height)
        let scene = SKScene(size: self.frame.size)
        print(scene)
        scene.backgroundColor = .clear
        self.presentScene(scene)
        self.allowsTransparency = true
        self.anchor.size = CGSize(width: scene.frame.width , height: scene.frame.height)
            self.anchor.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: scene.frame.maxY + (scene.frame.maxY - scene.frame.minY) / 2 - self.dur)
        NotificationCenter.default.addObserver(self, selector: #selector(self.addAnchor), name: NSNotification.Name(rawValue: "addAnchor"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.down), name: NSNotification.Name(rawValue: "down"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.up), name: NSNotification.Name(rawValue: "up"), object: nil)
       }
    }
    @objc func addAnchor(){
        scene!.addChild(self.anchor)
    }
    @objc func down(){
        scene!.removeAllChildren()
        scene!.addChild(anchor)
        anchor.run(SKAction.moveBy(x: 0, y: -(scene!.frame.maxY - scene!.frame.minY) + dur, duration: UserDefaults.standard.double(forKey: "random")))
    }
    @objc func up(){
        anchor.run(SKAction.moveBy(x: 0, y: (scene!.frame.maxY - scene!.frame.minY), duration: 2))
    
  }
}
