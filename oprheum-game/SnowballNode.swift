//
//  SnowballNode.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//

import SpriteKit

class SnowballNode: SKNode {
    var snowballNode: SKShapeNode!
    var mass: CGFloat = 8
    var mass0: CGFloat = 0
    let whiteColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    
    
    override init() {
        super.init()
        
        
        self.name = "Snowball"
        redrawSnowball()
        unselect()
    }
    
    func setSnowballMass(mass: CGFloat) {
        self.mass = mass
        redrawSnowball()
    }
    
    func redrawSnowball() {
        self.removeAllChildren()
        let radius = mass * 10
        snowballNode = SKShapeNode(circleOfRadius: radius)
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.mass = mass
        self.addChild(snowballNode)
        snowballNode.fillColor = whiteColor
    }
    
    func pinchBegan(scale: CGFloat){
        mass0 = mass
    }
    
    func pinchChanged(scale: CGFloat) {
        setSnowballMass(mass0 * scale)
    }
    
    func pinchEnded(scale: CGFloat) {
        setSnowballMass(mass0 * scale)
    }
    
    func select() {
        snowballNode.fillColor = whiteColor
        // snowballNode.fillColor = SKColor.whiteColor()
    }
    
    func unselect() {
        snowballNode.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}