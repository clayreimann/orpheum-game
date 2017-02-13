//
//  SnowballNode.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.

import SpriteKit

class SnowballNode: SKNode {

    static let maximumMass: CGFloat = 13
    static let minimumMass: CGFloat = 1

    let whiteColor = SKColor.whiteColor()

    var snowball: SKShapeNode!
    var mass: CGFloat = SnowballNode.maximumMass
    var mass0: CGFloat = 0 // this needs a better name

    override init() {
        super.init()

        self.name = "Snowball"
        redrawSnowball()
        unselect()
    }

    func setSnowballMass(mass: CGFloat) {
        var newMass = mass
        if newMass > SnowballNode.maximumMass {
            newMass = SnowballNode.maximumMass
        }
        if newMass < SnowballNode.minimumMass {
            newMass = SnowballNode.minimumMass
        }
        print("newMass %f mass %f", newMass, mass)
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

    func pinchBegan(scale: CGFloat) {
        mass0 = mass
    }

    func pinchChanged(scale: CGFloat) {
        setSnowballMass(mass0 * scale)
    }

    func pinchEnded(scale: CGFloat) {
        setSnowballMass(mass0 * scale)
    }

    func select() {
        snowball.fillColor = whiteColor
    }

    func unselect() {
        snowball.fillColor = SKColor.blueColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
