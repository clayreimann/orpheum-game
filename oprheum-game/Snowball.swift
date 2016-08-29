//
//  Snowball.swift
//  Ramp Game - Yichen
//
//  Created by Yichen Yao on 3/22/16.
//  Copyright © 2016 Yichen Yao. All rights reserved.
//

import SpriteKit

class Snowball: SKNode {
    
    var mass: CGFloat
    
    init(weight: CGFloat) {
        mass = weight
        super.init()
        
        configureChildNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureChildNodes() {
        let snowball = SKShapeNode(circleOfRadius: 30 * mass)
        snowball.position = CGPoint(x: 30 * mass, y: 30 * mass)
        snowball.name = "snowball"
        snowball.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.00)
        snowball.physicsBody = SKPhysicsBody(circleOfRadius: 5 * mass)
        snowball.physicsBody?.mass = mass
        
        self.addChild(snowball)
    }

    func massChange (newWeight: CGFloat) {
        mass = newWeight
        configureChildNodes()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        let width = 60 * mass
        let height = 60 * mass
        let x = 0.5 * width
        let y = 0.5 * height

        return CGRect(x: x, y: y, width: width, height: height)
    }
}
