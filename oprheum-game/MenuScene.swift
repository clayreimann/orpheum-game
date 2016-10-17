//
//  MenuScene.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.

import SpriteKit

class MenuScene: SKScene {
    static let SnowballButtonName = "SnowballGameButton"
    static let LeverButtonName = "LeverGameButton"

    var gameViewController: GameViewController!
    var button: SKNode!

    override func didMoveToView(view: SKView) {
        let snowButtonWidth = 1/5 * self.frame.size.width
        let snowButtonHeight = 1/6 * self.frame.size.height
        let leverButtonWidth = 1/5 * self.frame.width
        let leverButtonHeight = 1/6 * self.frame.height
        let toggleSnowballSimulation = SKShapeNode(rect: CGRect(x: 0, y: 0, width: snowButtonWidth, height: snowButtonHeight), cornerRadius: 7)
        toggleSnowballSimulation.position = CGPoint(x: 1/5 * self.frame.width, y: 1/3 * self.frame.height)
        toggleSnowballSimulation.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        toggleSnowballSimulation.name = MenuScene.SnowballButtonName
        self.addChild(toggleSnowballSimulation)

        let toggleSnowballSimulationText = SKLabelNode(text: "Ramp")
        toggleSnowballSimulationText.position = CGPoint(x: (self.frame.width/2.0)-80, y: (self.frame.height/2.0)+10)
        toggleSnowballSimulationText.fontSize = 45
        toggleSnowballSimulationText.fontColor = SKColor.darkGrayColor()
        toggleSnowballSimulationText.userInteractionEnabled = false
        toggleSnowballSimulation.addChild(toggleSnowballSimulationText)

        let toggleLeverSimulation = SKShapeNode(rect: CGRect(x: 0, y: 0, width: leverButtonWidth, height: leverButtonHeight), cornerRadius: 4)
        toggleLeverSimulation.position = CGPoint(x: 3/5*(self.frame.width), y: 1/3*(self.frame.height))
        toggleLeverSimulation.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        toggleLeverSimulation.name = MenuScene.LeverButtonName
        self.addChild(toggleLeverSimulation)

        let toggleLeverSimulationText = SKLabelNode(text: "Lever")
        toggleLeverSimulationText.position = CGPoint(x: leverButtonWidth/2, y: leverButtonHeight/3)
        toggleLeverSimulationText.fontSize = 45
        toggleLeverSimulationText.fontColor = SKColor.blackColor()
        toggleLeverSimulationText.userInteractionEnabled = false
        toggleLeverSimulation.addChild(toggleLeverSimulationText)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let nodes = self.nodesAtPoint(touch.locationInNode(self))
            for node in nodes {
                if let name = node.name {
                    print("tapped node \(name) \(node.frame)")

                    if name == MenuScene.SnowballButtonName {
                        gameViewController.startSnowballGame()
                        return
                    }

                    if name == MenuScene.LeverButtonName {
                        gameViewController.startLeverGameNew()
                        return
                    }
                }
            }
        }
    }

}
