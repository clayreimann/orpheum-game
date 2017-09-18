//
//  RampNode.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland, Anna Troutt. All rights reserved.
//

import SpriteKit

class RampNode: SKNode {
    public static let initialSize: CGFloat = 200

    static let rampColor = SKColor(red: 0.039, green: 1.000, blue: 0.004, alpha: 1.00)
    static let easyMaximumSize: CGFloat = 675
    static let mediumMaximumSize: CGFloat = 400
    static let hardMaximumSize: CGFloat = 300
    static let minimumSize: CGFloat = 100

    var rampImage = #imageLiteral(resourceName: "Coding_grid.png")
    var rampNode: SKSpriteNode!
    var cropNode: SKCropNode!

    var triangleHeight: CGFloat = RampNode.easyMaximumSize
    var triangleWidth: CGFloat = RampNode.easyMaximumSize
    var initialX: CGFloat = 0
    var initialY: CGFloat = 0

    var maxSize: CGFloat = RampNode.easyMaximumSize
    var minSize: CGFloat = RampNode.minimumSize

    override init() {
        super.init()

        self.name = "Ramp"

        let scale = 675 / rampImage.size.height
        let rampNode = SKSpriteNode(imageNamed: "Coding_grid")
        rampNode.setScale(3*scale)
        rampNode.physicsBody?.mass = 10000
        rampNode.position = CGPoint(x: 0, y: 0)

        cropNode = SKCropNode()
        cropNode.addChild(rampNode)

        self.redrawTriangle(width: triangleWidth, height: triangleHeight)
        self.unselect()
        self.addChild(cropNode)
    }

    func rampPath(width: CGFloat, height: CGFloat) -> CGPath {
        let rampPath = CGMutablePath()
        rampPath.move(to: CGPoint(x: 0, y: height))
        rampPath.addLine(to: CGPoint(x: 0, y: 0))
        rampPath.addLine(to: CGPoint(x: width, y: 0))
        rampPath.closeSubpath()

        return rampPath
    }

    func redrawTriangle(width: CGFloat, height: CGFloat) {
        let path = rampPath(width: width, height: height)
        let physicsBody = SKPhysicsBody(polygonFrom: path)
        physicsBody.isDynamic = false
        cropNode.physicsBody = physicsBody

        let maskNode = SKShapeNode(path:path)
        maskNode.fillColor = SKColor.white
        cropNode.maskNode = maskNode
    }

    func pinchBegan(_ touch1: CGPoint, touch2: CGPoint) {
        initialX = touch2.x - touch1.x
        initialY = touch1.y - touch2.y
    }

    func limitRampSize(_ val: CGFloat) -> CGFloat {
        var result = val

        if val > maxSize {
            result = maxSize
        } else if val < minSize {
            result = minSize
        }
        return result
    }

    func pinchChanged(_ touch1: CGPoint, touch2: CGPoint) {
        let xScale = (touch2.x - touch1.x) / initialX
        let yScale = (touch1.y - touch2.y) / initialY
        let xLimit = limitRampSize(triangleWidth * xScale)
        let yLimit = limitRampSize(triangleHeight * yScale)
        redrawTriangle(width: xLimit, height: yLimit)
    }

    func pinchEnded(_ touch1: CGPoint, touch2: CGPoint) {
        let xScale = (touch2.x - touch1.x) / initialX
        let yScale = (touch1.y - touch2.y) / initialY
        triangleWidth = limitRampSize(triangleWidth * xScale)
        triangleHeight = limitRampSize(triangleHeight * yScale)
        redrawTriangle(width: triangleWidth, height: triangleHeight)
    }

    func select() {
//        rampNode.fillColor = RampNode.selectedColor
    }

    func unselect() {
//        rampNode.fillColor = RampNode.rampColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
