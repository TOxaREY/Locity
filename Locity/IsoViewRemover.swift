//
//  IsoViewRemover.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 10/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class IsoViewRemover: SKView {
    let iso = SKSpriteNode(imageNamed: "iso.png")
    override func didMoveToSuperview() {
////Dispatch for loading view constraints
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let scene = SKScene(size: self.frame.size)
            scene.backgroundColor = .clear
            scene.physicsWorld.gravity = CGVector.zero
            self.presentScene(scene)
            self.allowsTransparency = true
            let hSize = isoViewHeight
            print(hSize)
            self.iso.size = CGSize(width: hSize * 1.3, height: hSize)
            self.iso.position = CGPoint(x: (scene.frame.maxX - scene.frame.minX) / 2, y: hSize / 2)
            self.iso.zRotation = 0
            NotificationCenter.default.addObserver(self, selector: #selector(self.addIsoFrameRemover), name: NSNotification.Name(rawValue: "addIsoFrameRemover"), object: nil)
        }
    }
    
    @objc func addIsoFrameRemover(){
        scene!.addChild(iso)
    }
}

