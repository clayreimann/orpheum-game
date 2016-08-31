//
//  RampNode.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//

import SpriteKit

class RampNode: SKNode {
    var rampNode: SKShapeNode!
    var triangleHeight: CGFloat = 400
    var triangleWidth: CGFloat = 400
    var x0: CGFloat = 0
    var y0: CGFloat = 0
    
    override init() {
        super.init()
        
        self.name = "Ramp"
        
        rampNode = SKShapeNode()
        rampNode.physicsBody?.mass=10000
        self.redrawTriangle(triangleWidth, height: triangleHeight)
        self.unselect()
        
        self.addChild(rampNode)
    }
    
    func redrawTriangle(width: CGFloat, height: CGFloat) {
        let rampPath = CGPathCreateMutable()
        CGPathMoveToPoint(rampPath, nil, 0, height)
        CGPathAddLineToPoint(rampPath, nil, 0, 0)
        CGPathAddLineToPoint(rampPath, nil, width, 0)
        CGPathCloseSubpath(rampPath)
        
        rampNode.path = rampPath
        rampNode.physicsBody = SKPhysicsBody(polygonFromPath: rampPath)
    }
    
    func pinchBegan(touch1:CGPoint, touch2:CGPoint){
        x0 = touch2.x - touch1.x
        y0 = touch1.y - touch2.y
    }
    
    func pinchChanged(touch1:CGPoint, touch2:CGPoint) {
        let xScale = (touch2.x - touch1.x) / x0
        let yScale = (touch1.y - touch2.y) / y0
        let xLimit = limit(triangleWidth * xScale)
        let yLimit = limit(triangleHeight * yScale)
        redrawTriangle(xLimit, height: yLimit)
    }
    
    func pinchEnded(touch1:CGPoint, touch2:CGPoint) {
        let xScale = (touch2.x - touch1.x) / x0
        let yScale = (touch1.y - touch2.y) / y0
        triangleWidth = limit(triangleWidth * xScale)
        triangleHeight = limit(triangleHeight * yScale)
        redrawTriangle(triangleWidth, height: triangleHeight)
    }
    
    func select() {
        rampNode.fillColor = SKColor.redColor()
    }
    
    func unselect() {
        rampNode.fillColor = SKColor(red: 0.039, green: 1.000, blue: 0.004, alpha: 1.00)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
