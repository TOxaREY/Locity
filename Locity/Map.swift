//
//  Map.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 25/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
import SQLite

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

class Map: SKView {
    let ring = SKSpriteNode(imageNamed: "ringGray.png")
    let ring2 = SKSpriteNode(imageNamed: "ringGray2.png")
    let ring3 = SKSpriteNode(imageNamed: "ringGray3.png")
    let ringWrong = SKSpriteNode(imageNamed: "ringRed.png")
    let ringRight = SKSpriteNode(imageNamed: "ringGreen.png")
    var delta = CGFloat()
    var square = String()
    var maxX = CGFloat()
    var maxY = CGFloat()
    var minX = CGFloat()
    var minY = CGFloat()
    deinit {
        print("deinitSKVMapVCM")
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
        
        do {
            for sq in try base.database.prepare(base.countriesTable.select(base.square).filter(base.id == idSelectCountry)){
                square = sq[base.square]
            }
        } catch {
            print(error)
        }
        switch square {
        case "N": delta = ((maxY - minY) - ((maxX - minX) * ((maxY - minY) / (maxX - minX)))) / 2
        case "S": delta = ((maxY - minY) - ((maxX - minX) * 1.4621578)) / 2
        default:
            break
        }
        let uDRingSize = (maxX - minX) * 0.04
        ringSize = uDRingSize * 1.5
        NotificationCenter.default.addObserver(self, selector: #selector(addCitys), name: NSNotification.Name(rawValue: "addCitys"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(coorCityHard), name: NSNotification.Name(rawValue: "coorCityHard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetCitys), name: NSNotification.Name(rawValue: "resetCitys"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(coordinatesRight), name: NSNotification.Name(rawValue: "coordinatesRight"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(coordinatesWrong2), name: NSNotification.Name(rawValue: "coordinatesWrong2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(coordinatesWrong3), name: NSNotification.Name(rawValue: "coordinatesWrong3"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drawAndScaleCircle), name: NSNotification.Name(rawValue: "drawAndScaleCircle"), object: nil)
    }
    @objc func addCitys(){
        ringPosition(name: ring, x: cityX, y: cityY, pulseOn: true, post: true, city:"city")
        ringPosition(name: ring2, x: city2X, y: city2Y, pulseOn: true, post: true, city:"city2")
        ringPosition(name: ring3, x: city3X, y: city3Y, pulseOn: true, post: true, city:"city3")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "addCity"), object: nil)
    }
    @objc func coorCityHard(){
        ringRight.size = CGSize(width: (maxX - minX) * 0.04, height: (maxX - minX) * 0.04)
        ringRight.position = CGPoint(x: (maxX - minX) / cityX, y: (((maxY - delta) - (minY + delta)) / cityY) + delta)
        cityCoorX = ringRight.position.x
        cityCoorY = ringRight.position.y
    }
    @objc func drawAndScaleCircle(){
        let circle = SKShapeNode(circleOfRadius: radiusToch)
        circle.position = ringRight.position
        if resultTouchWrong {
            UIDevice.vibrate()
            circle.fillColor = UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.1)
            circle.strokeColor = UIColor.red
        } else {
            circle.fillColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.1)
            circle.strokeColor = UIColor.green
        }
        circle.lineWidth = 1
        scene!.addChild(self.ringRight)
        scene!.addChild(circle)
        let scaleCircle = SKAction.scale(to: 0.01, duration: 2.0)
        circle.run(scaleCircle)
    }
    
    @objc func resetCitys(){
        scene!.removeAllChildren()
        scene!.removeAllActions()
    }
    @objc func coordinatesRight(){
        scene!.removeAllChildren()
        ringPosition(name: ringRight, x: cityX, y: cityY, pulseOn: false, post: false, city:"")
    }
    @objc func coordinatesWrong2(){
        scene!.removeAllChildren()
        ringPosition(name: ringWrong, x: city2X, y: city2Y, pulseOn: false, post: false, city:"")
        UIDevice.vibrate()
    }
    @objc func coordinatesWrong3(){
        scene!.removeAllChildren()
        ringPosition(name: ringWrong, x: city3X, y: city3Y, pulseOn: false, post: false, city:"")
        UIDevice.vibrate()
    }
    
    func pulse(name:SKSpriteNode){
        let pulseUp = SKAction.scale(to: 1.25, duration: 0.15)
        let pulseDown = SKAction.scale(to: 0.75, duration: 0.30)
        let pulseReturn = SKAction.scale(to: 1, duration: 0.15)
        let pulse = SKAction.sequence([pulseUp, pulseDown, pulseReturn])
        let rep = SKAction.repeat(pulse, count: 2)
        name.run(rep, completion: {goTouch = true})
    }
    func ringPosition(name:SKSpriteNode,x:CGFloat,y:CGFloat,pulseOn:Bool,post:Bool,city:String){
        name.size = CGSize(width: (maxX - minX) * 0.04, height: (maxX - minX) * 0.04)
        name.position = CGPoint(x: (maxX - minX) / x, y: (((maxY - delta) - (minY + delta)) / y) + delta)
        scene!.addChild(name)
        if pulseOn {
        pulse(name: name)
        }
        if post {
            switch city {
            case "city": cityCoorX = name.position.x; cityCoorY = name.position.y
            case "city2": city2CoorX = name.position.x; city2CoorY = name.position.y
            case "city3": city3CoorX = name.position.x; city3CoorY = name.position.y
            default: break
            }
        }
    }
}
