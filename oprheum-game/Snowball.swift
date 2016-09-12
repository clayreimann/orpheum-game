//
//  Snowball.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//

import SpriteKit

class Snowball: SKNode {
    static let SnowballColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.00)
    static let DensityFactor :CGFloat = 20

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
        let snowball = SKShapeNode(circleOfRadius: Snowball.DensityFactor * mass)
        snowball.position = CGPoint(x: Snowball.DensityFactor * mass, y: Snowball.DensityFactor * mass)
        snowball.name = "snowball"
        snowball.fillColor = Snowball.SnowballColor
        snowball.physicsBody = SKPhysicsBody(circleOfRadius: 5 * mass) // why is the physics body not the same size as the shape?
        snowball.physicsBody?.mass = mass
        
        self.addChild(snowball)
    }

    func massChange (newWeight: CGFloat) {
        mass = newWeight
        configureChildNodes()
    }
    
    // Why are we doing this?
    override func calculateAccumulatedFrame() -> CGRect {
        let width = 60 * mass
        let height = 60 * mass
        let x = 0.5 * width
        let y = 0.5 * height

        return CGRect(x: x, y: y, width: width, height: height)
    }
}
