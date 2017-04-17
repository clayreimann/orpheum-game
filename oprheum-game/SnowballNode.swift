//
//  SnowballNode.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland, Anna Troutt. All rights reserved.

import SpriteKit

class SnowballNode: SKNode {

    static let SnowballColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.00)

    static let maximumMass: CGFloat = 13
    static let minimumMass: CGFloat = 1

    let whiteColor = SKColor.white

    var snowball: SKShapeNode!
    var mass: CGFloat = SnowballNode.maximumMass
    var mass0: CGFloat = 0 // this needs a better name

    override init() {
        super.init()

        self.name = "Snowball"
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
        self.removeAllChildren()
        let radius = mass * 10
        snowball = SKShapeNode(circleOfRadius: radius)
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.mass = mass
        self.addChild(snowball)
        snowball.fillColor = whiteColor
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
        snowball.fillColor = whiteColor
    }

    func unselect() {
        snowball.fillColor = SKColor.blue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
