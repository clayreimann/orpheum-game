//
//  MenuScene.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.

import SpriteKit

class MenuScene: BaseScene {
    static let snowballButtonName = "snowballGameButton"
    static let leverButtonName = "leverGameButton"

    override func didMove(to view: SKView) {
        let cornerRadius: CGFloat = 10
        let fontSize: CGFloat = 40
        let buttonSize = CGSize(width: (1/2) * frame.width, height: (1/4) * frame.height)

        let snowballGameButton = ButtonNode(name: MenuScene.snowballButtonName, text: "Snowball", size: buttonSize)
        snowballGameButton.cornerRadius = cornerRadius
        snowballGameButton.fontSize = fontSize
        snowballGameButton.position = CGPoint(x: 1/4 * frame.width, y: 1/2 * frame.height)
        self.addChild(snowballGameButton)

        let leverGameButton = ButtonNode(name: MenuScene.leverButtonName, text: "Castle", size: buttonSize)
        leverGameButton.cornerRadius = cornerRadius
        leverGameButton.fontSize = fontSize
        leverGameButton.position = CGPoint(x: 3/4 * self.frame.width, y: 1/2 * self.frame.height)
        self.addChild(leverGameButton)
    }

    func snowballGameButtonTouched(_ atPoint: NSValue) -> Bool {
        gameViewController.startSnowballGame()
        return true
    }

    func leverGameButtonTouched(_ atPoint: NSValue) -> Bool {
        gameViewController.startLeverGame()
        return true
    }

}
