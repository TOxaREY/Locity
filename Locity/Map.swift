//
//  Map.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 25/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit

class Map: SKView {
    let ring = SKSpriteNode(imageNamed: "ringGray.png")
    let ring2 = SKSpriteNode(imageNamed: "ringGray.png")
    let ring3 = SKSpriteNode(imageNamed: "ringGray.png")
    let ringWrong = SKSpriteNode(imageNamed: "ringRed.png")
    let ringRight = SKSpriteNode(imageNamed: "ringGreen.png")
    var delta = CGFloat()
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        self.presentScene(scene)
        self.allowsTransparency = true
        delta = ((scene.frame.maxY - scene.frame.minY) - ((scene.frame.maxX - scene.frame.minX) * 1.4621578)) / 2
        UserDefaults.standard.set(ring.size.height, forKey: "ringSize")
        NotificationCenter.default.addObserver(self, selector: #selector(addCitys), name: NSNotification.Name(rawValue: "addCitys"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetCitys), name: NSNotification.Name(rawValue: "resetCitys"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(coordinatesRight), name: NSNotification.Name(rawValue: "coordinatesRight"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(coordinatesWrong2), name: NSNotification.Name(rawValue: "coordinatesWrong2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(coordinatesWrong3), name: NSNotification.Name(rawValue: "coordinatesWrong3"), object: nil)
    }
    @objc func addCitys(){
        ringPosition(name: ring, x: cityX, y: cityY, pulseOn: true, post: true, city:"city")
        ringPosition(name: ring2, x: city2X, y: city2Y, pulseOn: true, post: true, city:"city2")
        ringPosition(name: ring3, x: city3X, y: city3Y, pulseOn: true, post: true, city:"city3")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "addCity"), object: nil)
    }
    @objc func resetCitys(){
        scene!.removeAllChildren()
    }
    @objc func coordinatesRight(){
        scene!.removeAllChildren()
        ringPosition(name: ringRight, x: cityX, y: cityY, pulseOn: false, post: false, city:"")
    }
    @objc func coordinatesWrong2(){
        scene!.removeAllChildren()
        ringPosition(name: ringWrong, x: city2X, y: city2Y, pulseOn: false, post: false, city:"")
    }
    @objc func coordinatesWrong3(){
        scene!.removeAllChildren()
        ringPosition(name: ringWrong, x: city3X, y: city3Y, pulseOn: false, post: false, city:"")
    }
    
    func pulse(name:SKSpriteNode){
        let pulseUp = SKAction.scale(to: 0.75, duration: 0.75)
        let pulseDown = SKAction.scale(to: 1, duration: 0.75)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        name.run(repeatPulse)
    }
    func ringPosition(name:SKSpriteNode,x:CGFloat,y:CGFloat,pulseOn:Bool,post:Bool,city:String){
        name.size = CGSize(width: (scene!.frame.maxX - scene!.frame.minX) * 0.04, height: (scene!.frame.maxX - scene!.frame.minX) * 0.04)
        name.position = CGPoint(x: (scene!.frame.maxX - scene!.frame.minX) / x, y: (((scene!.frame.maxY - delta) - (scene!.frame.minY + delta)) / y) + delta)
        scene!.addChild(name)
        if pulseOn {
        pulse(name: name)
        }
        if post {
            UserDefaults.standard.set(name.position.x, forKey: "\(city)X")
            UserDefaults.standard.set(name.position.y, forKey: "\(city)Y")
        }
    }
}
