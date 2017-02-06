//
//  RampNode.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland, Anna Troutt. All rights reserved.
//

import SpriteKit

class RampNode: SKNode {
    static let selectedColor = SKColor.redColor()
    static let rampColor = SKColor(red: 0.039, green: 1.000, blue: 0.004, alpha: 1.00)
    static let easyMaximumSize: CGFloat = 675
    static let mediumMaximumSize: CGFloat = 475
    static let hardMaximumSize: CGFloat = 275
    static let minimumSize: CGFloat = 100

    var rampNode: SKShapeNode!
    var triangleHeight: CGFloat = 100
    var triangleWidth: CGFloat = 100
    var initialX: CGFloat = 0
    var initialY: CGFloat = 0

    var maxSize: CGFloat = RampNode.easyMaximumSize
    var minSize: CGFloat = RampNode.minimumSize

    override init() {
        super.init()

        self.name = "Ramp"

        rampNode = SKShapeNode()
        rampNode.physicsBody?.mass=10000
        rampNode.position = CGPoint(x: 0, y: 0)
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
        rampNode.physicsBody?.dynamic = false
    }

    func pinchBegan(touch1: CGPoint, touch2: CGPoint) {
        initialX = touch2.x - touch1.x
        initialY = touch1.y - touch2.y
    }

    func limitRampSize(val: CGFloat) -> CGFloat {
        var result = val

        if val > maxSize {
            result = maxSize
        } else if val < minSize {
            result = minSize
        }

        return result
    }

    func pinchChanged(touch1: CGPoint, touch2: CGPoint) {
        let xScale = (touch2.x - touch1.x) / initialX
        let yScale = (touch1.y - touch2.y) / initialY
        let xLimit = limitRampSize(triangleWidth * xScale)
        let yLimit = limitRampSize(triangleHeight * yScale)
        redrawTriangle(xLimit, height: yLimit)
    }

    func pinchEnded(touch1: CGPoint, touch2: CGPoint) {
        let xScale = (touch2.x - touch1.x) / initialX
        let yScale = (touch1.y - touch2.y) / initialY
        triangleWidth = limitRampSize(triangleWidth * xScale)
        triangleHeight = limitRampSize(triangleHeight * yScale)
        redrawTriangle(triangleWidth, height: triangleHeight)
    }

    func select() {
        rampNode.fillColor = RampNode.selectedColor
    }

    func unselect() {
        rampNode.fillColor = RampNode.rampColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
