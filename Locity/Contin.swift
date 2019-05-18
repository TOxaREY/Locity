//
//  Contin.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 15/05/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit
import SQLite

class Contin: SKView {
    let ring = SKSpriteNode(imageNamed: "ringGreen.png")
    var contin = SKSpriteNode()
    var delta = CGFloat()
    var square = String()
    var maxX = CGFloat()
    var maxY = CGFloat()
    var minX = CGFloat()
    var minY = CGFloat()
    var xCountry = CGFloat()
    var yCountry = CGFloat()

    deinit {
        print("deinitSKVContinVCM")
    }
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        self.presentScene(scene)
        self.allowsTransparency = true
        maxX = scene.frame.maxX
        maxY = scene.frame.maxY
        minX = scene.frame.minX
        minY = scene.frame.minY
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            do {
                for idContin in try base.database.prepare(base.countriesTable.select(base.id_continent).filter(base.id == idSelectCountry)){
                    switch idContin[base.id_continent] {
                    case 1: self.contin = SKSpriteNode(imageNamed: "Oceania.png")
                    case 2: self.contin = SKSpriteNode(imageNamed: "Asia.png")
                    case 3: self.contin = SKSpriteNode(imageNamed: "Africa.png")
                    case 4: self.contin = SKSpriteNode(imageNamed: "Europe.png")
                    case 5: self.contin = SKSpriteNode(imageNamed: "America.png")
                    default: break
                    }
                }
            } catch {
                print(error)
            }
            do {
                for country in try base.database.prepare(base.countriesTable.select(base.x).filter(base.id == idSelectCountry)){
                    self.xCountry = CGFloat(country[base.x])
                }
            } catch {
                print(error)
            }
            do {
                for country in try base.database.prepare(base.countriesTable.select(base.y).filter(base.id == idSelectCountry)){
                    self.yCountry = CGFloat(country[base.y])
                }
            } catch {
                print(error)
            }
            do {
                for sq in try base.database.prepare(base.countriesTable.select(base.square).filter(base.id == idSelectCountry)){
                    self.square = sq[base.square]
                }
            } catch {
                print(error)
            }
            self.delta = ((self.maxY - self.minY) - ((self.maxX - self.minX) * 1.4621578)) / 2
            self.contin.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
            self.contin.size.width = scene.frame.width
            self.contin.size.height = scene.frame.width * 1.4621578
            self.contin.zPosition = 0
            self.ring.size = CGSize(width: (self.maxX - self.minX) * 0.04, height: (self.maxX - self.minX) * 0.04)
            self.ring.position = CGPoint(x: (self.maxX - self.minX) / self.xCountry, y: (((self.maxY - self.delta) - (self.minY + self.delta)) / self.yCountry) + self.delta)
            self.ring.zPosition = 1
            
            scene.addChild(self.ring)
            scene.addChild(self.contin)
        }
    }
}

