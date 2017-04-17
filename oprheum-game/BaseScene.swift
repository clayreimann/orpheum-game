//
//  BaseScene.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland, Anna Troutt. All rights reserved.
//

import SpriteKit

class BaseScene: SKScene {
    static let fontName = UIFont.boldSystemFont(ofSize: 1).fontName

    static let bigFontSize: CGFloat = 40

    static let smallButtonWidth = 125
    static let smallButtonHeight = 50
    static let smallButtonSize = CGSize(width: BaseScene.smallButtonWidth, height: BaseScene.smallButtonHeight)
    static let smallButtonRadius: CGFloat = 4.0
    static let smallFontSize: CGFloat = 20

    var gameViewController: GameViewController!
    var instructionOverlay: InstructionOverlayNode!

    var winOverlay = WinOverlayNode()
    var loseOverlay = LoseOverlayNode ()

    func createSmallButton(named name: String, text: String, atPoint position: CGPoint, withSize size: CGSize) -> SKNode {
        let button = ButtonNode(name: name, text: text, size: size)
        button.position = position
        button.fontSize = BaseScene.smallFontSize

        return button
    }

    /**
     *  Automatically attempt to call a func named <nodeName>Touched(atPoint: NSValue<CGPoint>)
     *  any such function should return a boolean value that, if true, will skip the evaluation of any other nodes that were touched
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            for node in nodes {
                if let name = node.name {
                    let sel = Selector("\(name)Touched:")
                    if self.responds(to: sel) {
                        if self.perform(sel, with: NSValue(cgPoint: location)) != nil {
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
