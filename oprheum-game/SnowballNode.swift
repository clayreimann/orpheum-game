//
//  SnowballNode.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland, Anna Troutt. All rights reserved.

import SpriteKit

class SnowballNode: SKNode {

    public static let initialMass: CGFloat = 5

    static let SnowballColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.00)
    static let maximumMass: CGFloat = 13
    static let minimumMass: CGFloat = 1

    let whiteColor = SKColor.white

    var snowballImage: UIImage!
    var snowball: SKSpriteNode!
    var mass: CGFloat = SnowballNode.initialMass
    var mass0: CGFloat = 0 // this needs a better name

    override init() {
        super.init()

        self.name = "Snowball"
        snowballImage = #imageLiteral(resourceName: "Coding_snowball")
        snowball = SKSpriteNode(imageNamed: "Coding_snowball")
        self.addChild(snowball)
        
        redrawSnowball()
        unselect()
    }

    func setSnowballMass(_ mass: CGFloat) {
        var newMass = mass
        if newMass > SnowballNode.maximumMass {
            newMass = SnowballNode.maximumMass
        }
        if newMass < SnowballNode.minimumMass {
            newMass = SnowballNode.minimumMass
        }
        print(String(format: "newMass %f mass %f", newMass, mass))
        self.mass = newMass
        redrawSnowball()
    }

    func redrawSnowball() {
        let radius = mass * 10
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.mass = mass

        
        let scale = radius / CGFloat(snowballImage.size.height / 3.14)
        print("\(scale)")
        self.snowball.setScale(scale)
    }

    func pinchBegan(_ scale: CGFloat) {
        mass0 = mass
    }

    func pinchChanged(_ scale: CGFloat) {
        setSnowballMass(mass0 * scale)
    }

    func pinchEnded(_ scale: CGFloat) {
        setSnowballMass(mass0 * scale)
    }

    func select() {
        snowball.alpha = 1.0
    }

    func unselect() {
        snowball.alpha = 0.8
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
