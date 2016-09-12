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
        let toggleSnowballSimulation = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 70, height: 50), cornerRadius: 4)
        toggleSnowballSimulation.position = CGPoint(x: 400, y: 315)
        toggleSnowballSimulation.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        toggleSnowballSimulation.name = MenuScene.SnowballButtonName
        self.addChild(toggleSnowballSimulation)

        let toggleSnowballSimulationText = SKLabelNode(text: "Ramp")
        toggleSnowballSimulationText.position = CGPoint(x: 0, y: 0)
        toggleSnowballSimulationText.fontSize = 20
        toggleSnowballSimulationText.fontColor = SKColor.darkGrayColor()
        toggleSnowballSimulationText.userInteractionEnabled = false
        toggleSnowballSimulation.addChild(toggleSnowballSimulationText)
    
        let toggleLeverSimulation = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 70, height: 50), cornerRadius: 4)
        toggleLeverSimulation.position = CGPoint(x: 50, y: 315)
        toggleLeverSimulation.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        toggleLeverSimulation.name = MenuScene.LeverButtonName
        self.addChild(toggleLeverSimulation)

        let toggleLeverSimulationText = SKLabelNode(text: "Lever")
        toggleLeverSimulationText.position = CGPoint(x: 0, y: 0)
        toggleLeverSimulationText.fontSize = 20
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
    
