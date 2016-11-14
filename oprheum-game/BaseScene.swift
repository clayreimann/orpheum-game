//
//  BaseScene.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//

import SpriteKit

class BaseScene: SKScene {
    static let fontName = UIFont.boldSystemFontOfSize(1).fontName
    static let bigButtonWidth = 200
    static let bigButtonHeight = 100
    static let bigButtonSize = CGSize(width: BaseScene.bigButtonWidth, height: BaseScene.bigButtonHeight)
    static let bigButtonRadius: CGFloat = 7.0
    static let bigFontSize: CGFloat = 40

    static let smallButtonWidth = 125
    static let smallButtonHeight = 50
    static let smallButtonSize = CGSize(width: BaseScene.smallButtonWidth, height: BaseScene.smallButtonHeight)
    static let smallButtonRadius: CGFloat = 4.0
    static let smallFontSize: CGFloat = 20

    var gameViewController: GameViewController!

    func createButton(named name: String, text: String, atPoint position: CGPoint, withSize size: CGSize) -> SKShapeNode {
        let button = SKShapeNode(rectOfSize: size, cornerRadius: BaseScene.bigButtonRadius)
        button.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        button.name = name
        button.position = position

        let label = SKLabelNode(text: text)
        label.position = CGPoint(x: 0, y: -1 * BaseScene.bigFontSize / 2)
        label.fontSize = BaseScene.bigFontSize
        label.fontName = BaseScene.fontName
        label.fontColor = SKColor.darkGrayColor()
        label.userInteractionEnabled = false
        button.addChild(label)

        return button
    }

    /**
     *  Automatically attempt to call a func named <nodeName>Touched(atPoint: NSValue<CGPoint>)
     *  any such function should return a boolean value that, if true, will skip the evaluation of any other nodes that were touched
     */
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let nodes = self.nodesAtPoint(location)
            for node in nodes {
                if let name = node.name {
                    let sel = Selector("\(name)Touched:")
                    if self.respondsToSelector(sel) {
                        if self.performSelector(sel, withObject: NSValue(CGPoint: location)) != nil {
                            print("skipping further evaluation after calling \(sel)")
                            return
                        } else {
                            print("continuing to call handlers after calling \(sel)")
                        }
                    }
                }
            }
        }
    }

}
