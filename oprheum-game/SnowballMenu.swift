//
//  SnowballMenu.swift
//  orpheum-game
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland, Anna Troutt. All rights reserved.
//
//use max size from RampNode (for max size as snowball and ramp)

import SpriteKit

class SnowballMenu: SKNode {
    static let easyButtonName = "EasyButton"
    override init() {
        super.init()
        let node = SKShapeNode(rect: CGRect(x: 350, y: 100, width: 300, height: 600), cornerRadius: 5)
        node.fillColor = SKColor.gray
        self.addChild(node)

        let buttonSize = CGSize(width: 150, height: 100)
        let easyButton = ButtonNode(name: "easyButton", text: "Easy", size: buttonSize)
        easyButton.position = CGPoint(x: 500, y: 620)
        node.addChild(easyButton)

        let mediumButton = ButtonNode(name: "mediumButton", text: "Medium", size: buttonSize)
        mediumButton.position = CGPoint(x: 500, y: 490)
        node.addChild(mediumButton)

        let hardButton = ButtonNode(name: "hardButton", text: "Hard", size: buttonSize)
        hardButton.position = CGPoint(x: 500, y: 360)
        node.addChild(hardButton)

        let backToMenuButton = ButtonNode(name: "backToMenuButton", text: "Main Menu", size: buttonSize)
        backToMenuButton.position = CGPoint(x: 500, y: 175)
        node.addChild(backToMenuButton)

        let exitButton = ButtonNode(name: "exitButton", text: "X", size: CGSize(width: 60, height: 60))
        exitButton.cornerRadius = 30
        exitButton.position = CGPoint(x: 635, y: 700)
        node.addChild(exitButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
