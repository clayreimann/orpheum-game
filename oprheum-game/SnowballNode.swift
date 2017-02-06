//
//  SnowballNode.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.

import SpriteKit

class SnowballNode: SKNode {
    let whiteColor = SKColor.whiteColor()

    var SnowballNode: SKShapeNode!
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
        self.mass = newMass
        self.mass = mass
        redrawSnowball()
    }

    func redrawSnowball() {
        self.removeAllChildren()
        let radius = mass * 10
        SnowballNode = SKShapeNode(circleOfRadius: radius)
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.mass = mass
        self.addChild(SnowballNode)
        SnowballNode.fillColor = whiteColor
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
        SnowballNode.fillColor = whiteColor
    }

    func unselect() {
        SnowballNode.fillColor = SKShapeNode.SnowballColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
