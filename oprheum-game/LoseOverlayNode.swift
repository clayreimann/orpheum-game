//
//  LoseOverlayNode.swift
//  orpheum-game
//
//  Created by Anna Troutt on 1/3/17.
//
//

import SpriteKit

class LoseOverlayNode: SKNode {
    private var background: SKShapeNode!
    private var message: SKLabelNode!

    override init() {
        super.init()
        background = SKShapeNode(rectOfSize: CGSize(width: 3000, height: 2000))
        background.fillColor = SKColor.darkGrayColor()
        background.alpha = 0.25
        self.alpha = 0
        self.addChild(background)

        message = SKLabelNode(text: "☹️😖 You Lose 😱😭")
        message.position = CGPoint(x: 500, y: 400)
        message.fontName = "Hoefler Text"
        message.fontSize = 75
        self.addChild(message)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        let showAction = SKAction.fadeInWithDuration(0.3)
        self.runAction(showAction)
    }

    func hide() {
        let hideAction = SKAction.fadeOutWithDuration(0.3)
        self.runAction(hideAction)
    }
}
