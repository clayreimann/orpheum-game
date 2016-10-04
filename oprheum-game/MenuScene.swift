//
//  MenuScene.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.

import SpriteKit

class MenuScene: BaseScene {
    static let SnowballButtonName = "snowballGameButton"
    static let LeverButtonName = "leverGameButton"

    override func didMoveToView(view: SKView) {
        let buttonWidth = 1/5 * self.frame.size.width
        let buttonHeight = 1/6 * self.frame.size.height
        let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)

        let snowballGameButton = createBigButton(named: MenuScene.SnowballButtonName, text: "Snowball",
                                                 atPoint: CGPoint(x: 450, y: 365), withSize: buttonSize)
        self.addChild(snowballGameButton)


        let leverGameButton = createBigButton(named: MenuScene.LeverButtonName, text: "Castle",
                                              atPoint: CGPoint(x: 200, y: 365), withSize: buttonSize)
        self.addChild(leverGameButton)
    }

    func snowballGameButtonTouched(atPoint: NSValue) -> Bool {
        gameViewController.startSnowballGame()
        return true
    }

    func leverGameButtonTouched(atPoint: NSValue) -> Bool {
        gameViewController.startLeverGame()
        return true
    }

}
