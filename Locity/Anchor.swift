//
//  Anchor.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 08/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class Anchor: SKView {
    let anchor = SKSpriteNode(imageNamed: "anchor.png")
    var timer: Timer!
    var indentAnchorDown: CGFloat = 0.0
    deinit {
        print("deinitSKVAnchorVCC")
        deinitSKVAnchorVCC = true
    }
    override func didMoveToSuperview() {
////Dispatch for loading view constraints
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            switch UIScreen.main.bounds.height {
            case 896:
                self.indentAnchorDown = 52
            case 812:
                self.indentAnchorDown = 47
            case 736:
                self.indentAnchorDown = 40
            case 667:
                self.indentAnchorDown = 37
            case 568:
                self.indentAnchorDown = 31
            default:
                self.indentAnchorDown = 37
            }
            let scene = SKScene(size: self.frame.size)
            scene.backgroundColor = .clear
            self.presentScene(scene)
            self.allowsTransparency = true
            self.anchor.size = CGSize(width: scene.frame.width , height: scene.frame.height)
            self.anchor.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: scene.frame.maxY + (scene.frame.maxY - scene.frame.minY) / 2 - self.indentAnchorDown)
            NotificationCenter.default.addObserver(self, selector: #selector(self.addAnchor), name: NSNotification.Name(rawValue: "addAnchor"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.downAnchor), name: NSNotification.Name(rawValue: "downAnchor"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.upAnchor), name: NSNotification.Name(rawValue: "upAnchor"), object: nil)
        }
    }
    @objc func addAnchor(){
        scene!.removeAllChildren()
        scene!.addChild(self.anchor)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "addAnchor"), object: nil)
    }
    @objc func downAnchor(){
        scene!.removeAllChildren()
        scene!.addChild(anchor)
        anchor.run(SKAction.moveBy(x: 0, y: -(scene!.frame.maxY - scene!.frame.minY) + indentAnchorDown, duration: randomWheel))
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "downAnchor"), object: nil)
    }
    @objc func upAnchor(){
        anchor.run(SKAction.moveBy(x: 0, y: (scene!.frame.maxY - scene!.frame.minY), duration: 2.5))
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.scene!.removeAllChildren()
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "upAnchor"), object: nil)
    }
}

