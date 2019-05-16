//
//  MapCatalogView.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 28/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SpriteKit
import SQLite

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

    var arrowCat = String()

class MapCatalogView: SKView {
    let ringC = SKSpriteNode(imageNamed: "ringBlue.png")
    let ring1 = SKSpriteNode(imageNamed: "ringGray.png")
    let ring2 = SKSpriteNode(imageNamed: "ringGray.png")
    let ring3 = SKSpriteNode(imageNamed: "ringGray.png")
    let ring4 = SKSpriteNode(imageNamed: "ringGray.png")
    let ring5 = SKSpriteNode(imageNamed: "ringGray.png")
    let ring = SKSpriteNode(imageNamed: "ringGreen.png")
    let swipe = SKSpriteNode(imageNamed: "swipe.png")
    var map = SKSpriteNode()
    var contin = SKSpriteNode()
    var delta = CGFloat()
    var dictionaryCities:Dictionary<Int,String> = [:]
    var xCountry = CGFloat()
    var yCountry = CGFloat()
    
    
    deinit {
        print("deinitSKVMapCatalog")
    }
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        self.presentScene(scene)
        self.allowsTransparency = true
        delta = ((scene.frame.maxY - scene.frame.minY) - ((scene.frame.maxX - scene.frame.minX) * 1.4621578)) / 2
        NotificationCenter.default.addObserver(self, selector: #selector(addContin), name: NSNotification.Name(rawValue: "addContin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addMapAndCities), name: NSNotification.Name(rawValue: "addMapAndCities"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addCitiesCatalog), name: NSNotification.Name(rawValue: "addCitiesCatalog"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetMapAndCities), name: NSNotification.Name(rawValue: "resetMapAndCities"), object: nil)
    }
    @objc func addContin(){
        scene!.removeAllChildren()
        scene!.backgroundColor = UIColor(hex: "#d2b48cff")!
        do {
            for idContin in try base.database.prepare(base.countriesTable.select(base.id_continent).filter(base.id == idSelectCountry)){
                switch idContin[base.id_continent] {
                case 1: contin = SKSpriteNode(imageNamed: "Oceania.png")
                case 2: contin = SKSpriteNode(imageNamed: "Asia.png")
                case 3: contin = SKSpriteNode(imageNamed: "Africa.png")
                case 4: contin = SKSpriteNode(imageNamed: "Europe.png")
                case 5: contin = SKSpriteNode(imageNamed: "America.png")
                default: break
                }
            }
        } catch {
            print(error)
        }
        do {
            for country in try base.database.prepare(base.countriesTable.select(base.x).filter(base.id == idSelectCountry)){
                xCountry = CGFloat(country[base.x])
            }
        } catch {
            print(error)
        }
        do {
            for country in try base.database.prepare(base.countriesTable.select(base.y).filter(base.id == idSelectCountry)){
                yCountry = CGFloat(country[base.y])
            }
        } catch {
            print(error)
        }
        swipe.size = CGSize(width: (scene!.frame.maxX - scene!.frame.minX) * 0.1, height: (scene!.frame.maxX - scene!.frame.minX) * 0.1)
        swipe.position = CGPoint(x: scene!.size.width / 2, y: swipe.size.height / 1.5)
        swipe.zPosition = 1
        scene!.addChild(swipe)
        
        ring.size = CGSize(width: (scene!.frame.maxX - scene!.frame.minX) * 0.04, height: (scene!.frame.maxX - scene!.frame.minX) * 0.04)
        ring.position = CGPoint(x: (scene!.frame.maxX - scene!.frame.minX) / xCountry, y: (((scene!.frame.maxY - delta) - (scene!.frame.minY + delta)) / yCountry) + delta)
        ring.zPosition = 2
        scene!.addChild(ring)
        
        contin.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height / 2)
        contin.size.width = scene!.frame.width
        contin.size.height = scene!.frame.width * 1.4621578
        contin.zPosition = 0
        scene!.addChild(contin)
    }
    
    @objc func addMapAndCities(){
        scene!.removeAllChildren()
        scene!.backgroundColor = UIColor(hex: "#d2b48cff")!
        do {
            for mapImage in try base.database.prepare(base.countriesTable.select(base.map).filter(base.id == idSelectCountry)){
                map = SKSpriteNode(imageNamed: mapImage[base.map])
            }
        } catch {
            print(error)
        }
        do {
            var c = 1
            for city in try base.database.prepare(base.citiesTable.select(base.city).filter(base.id_country == idSelectCountry && base.capital == "N")){
                dictionaryCities[c] = city[base.city]
                c += 1
            }
        } catch {
            print(error)
        }
        map.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height / 2)
        map.size.width = scene!.frame.width
        map.size.height = scene!.frame.width * 1.4621578
        scene!.addChild(map)
        addCityToMap(name: ringC,cap: true, number: 0)
        addCityToMap(name: ring1,cap: false, number: 1)
        addCityToMap(name: ring2,cap: false, number: 2)
        addCityToMap(name: ring3,cap: false, number: 3)
        addCityToMap(name: ring4,cap: false, number: 4)
        addCityToMap(name: ring5,cap: false, number: 5)
    }
    @objc func addCitiesCatalog(){
        do {
            var c = 1
            for city in try base.database.prepare(base.citiesTable.select(base.city).filter(base.id_country == idSelectCountry && base.capital == "N")){
                dictionaryCities[c] = city[base.city]
                c += 1
            }
        } catch {
            print(error)
        }
        addCityToMap(name: ringC,cap: true, number: 0)
        addCityToMap(name: ring1,cap: false, number: 1)
        addCityToMap(name: ring2,cap: false, number: 2)
        addCityToMap(name: ring3,cap: false, number: 3)
        addCityToMap(name: ring4,cap: false, number: 4)
        addCityToMap(name: ring5,cap: false, number: 5)
    }
    @objc func resetMapAndCities(){
        scene!.removeAllChildren()
        dictionaryCities = [:]
    }
    
    func addCityToMap(name:SKSpriteNode, cap:Bool, number:Int) {
        var xCityCatalog = CGFloat()
        var yCityCatalog = CGFloat()
        let cityLabel = SKLabelNode()
        cityLabel.fontSize = 15
        cityLabel.fontColor = .black
        cityLabel.fontName = "Georgia-Bold"
        cityLabel.zPosition = 1
        if cap {
        do {
            for city in try base.database.prepare(base.citiesTable.select(base.x).filter(base.id_country == idSelectCountry && base.capital == "C")){
                xCityCatalog = CGFloat(city[base.x])
            }
        } catch {
            print(error)
        }
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.y).filter(base.id_country == idSelectCountry && base.capital == "C")){
                yCityCatalog = CGFloat(city[base.y])
                }
            } catch {
                print(error)
            }
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.city).filter(base.id_country == idSelectCountry && base.capital == "C")){
                    cityLabel.text = city[base.city]
                }
            } catch {
                print(error)
            }
        } else {
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.x).filter(base.city == dictionaryCities[number]!)){
                    xCityCatalog = CGFloat(city[base.x])
                }
            } catch {
                print(error)
            }
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.y).filter(base.city == dictionaryCities[number]!)){
                    yCityCatalog = CGFloat(city[base.y])
                }
            } catch {
                print(error)
            }
            cityLabel.text = dictionaryCities[number]
        }
        do {
            for arr in try base.database.prepare(base.countriesTable.select(base.arrow).filter(base.id == idSelectCountry)){
                arrowCat = arr[base.arrow]
            }
        } catch {
            print(error)
        }
        name.size = CGSize(width: (scene!.frame.maxX - scene!.frame.minX) * 0.04, height: (scene!.frame.maxX - scene!.frame.minX) * 0.04)
        name.position = CGPoint(x: (scene!.frame.maxX - scene!.frame.minX) / xCityCatalog, y: (((scene!.frame.maxY - delta) - (scene!.frame.minY + delta)) / yCityCatalog) + delta)
        name.zPosition = 0
        
        /////
//        let circle = SKShapeNode(circleOfRadius: ((scene!.frame.maxX - scene!.frame.minX) * 0.04) * 1.5)
//        circle.position = name.position
//        circle.strokeColor = UIColor.red
//        circle.lineWidth = 2
//        circle.zPosition = 2
//        scene!.addChild(circle)
        /////
        
        
        
        
        
        if arrowCat == "U" {
            if name.position.x <= scene!.frame.width / 2 {
                if name.position.x - cityLabel.frame.size.width / 2 <= 0 {
                    cityLabel.position = CGPoint(x: cityLabel.frame.size.width / 2, y: name.position.y + name.size.height / 2)
                } else {
                    cityLabel.position = CGPoint(x: name.position.x + 1.5 * name.size.height, y: name.position.y + name.size.height / 2)
                }
            } else {
                if cityLabel.frame.size.width / 2 + name.position.x - 1.5 * name.size.height >= scene!.frame.maxX {
                    cityLabel.position = CGPoint(x: scene!.frame.maxX - cityLabel.frame.size.width / 2, y: name.position.y + name.size.height / 2)
                } else {
                    cityLabel.position = CGPoint(x: name.position.x - 1.5 * name.size.height, y: name.position.y + name.size.height / 2)
                }
            }
        } else {
            cityLabel.zRotation = π / 2
            if name.position.y <= scene!.frame.height / 2 {
                if name.position.y - cityLabel.frame.size.height / 2 <= 0 {
                    cityLabel.position = CGPoint(x: name.position.x - name.size.width / 2, y: 0)
                } else {
                    cityLabel.position = CGPoint(x: name.position.x - name.size.height / 2, y: name.position.y + 1.5 * name.size.height)
                }
            } else {
                if cityLabel.frame.size.height / 2 + name.position.y - 1.5 * name.size.height >= scene!.frame.maxY {
                    cityLabel.position = CGPoint(x: name.position.x - name.size.height / 2, y: scene!.frame.maxY - cityLabel.frame.size.height / 2)
                } else {
                    cityLabel.position = CGPoint(x: name.position.x - name.size.height / 2, y: name.position.y - 1.5 * name.size.height)
                }
            }
        }
        scene!.addChild(name)
        scene!.addChild(cityLabel)
    }
    
}
