//
//  MenuScene.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    static let SnowballButtonName = "SnowballGameButton"
    static let LeverButtonName = "LeverGameButton"

    var gameViewController: GameViewController!
    var button: SKNode!

    override func didMoveToView(view: SKView) {
        let toggleSnowballSimulation = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 200, height: 100), cornerRadius: 7)
        toggleSnowballSimulation.position = CGPoint(x: 550, y: 100)
        toggleSnowballSimulation.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        toggleSnowballSimulation.name = MenuScene.SnowballButtonName
        self.addChild(toggleSnowballSimulation)

        let toggleSnowballSimulationText = SKLabelNode(text: "Ramp")
        toggleSnowballSimulationText.position = CGPoint(x:100, y: 30)
        toggleSnowballSimulationText.fontSize = 45
        toggleSnowballSimulationText.fontColor = SKColor.darkGrayColor()
        toggleSnowballSimulationText.userInteractionEnabled = false
        toggleSnowballSimulation.addChild(toggleSnowballSimulationText)
    
        let toggleLeverSimulation = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 200, height: 100), cornerRadius: 7)
        toggleLeverSimulation.position = CGPoint(x: 250, y: 100)
        toggleLeverSimulation.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        toggleLeverSimulation.name = MenuScene.LeverButtonName
        self.addChild(toggleLeverSimulation)

        let toggleLeverSimulationText = SKLabelNode(text: "Lever")
        toggleLeverSimulationText.position = CGPoint(x: 100, y: 30)
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
    
