//
//  MenuScene.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.

import SpriteKit

class MenuScene: BaseScene {
    static let SnowballButtonName = "snowballGameButton"
    static let LeverButtonName = "leverGameButton"

    override func didMoveToView(view: SKView) {
        let buttonWidth = 1/4 * self.frame.size.width
        let buttonHeight = 1/6 * self.frame.size.height
        let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)

        let snowballGameButton = createButton(named: MenuScene.SnowballButtonName, text: "Snowball",
                                              atPoint: CGPoint(x: 1/4 * self.frame.width, y: 1/2 * self.frame.height),
                                              withSize: buttonSize)
        self.addChild(snowballGameButton)


        let leverGameButton = createButton(named: MenuScene.LeverButtonName, text: "Castle",
                                           atPoint: CGPoint(x: 3/4 * self.frame.width, y: 1/2 * self.frame.height),
                                           withSize: buttonSize)
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
