//
//  MenuScene.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    var gameViewController: GameViewController!
    var button: SKNode!

    override func didMoveToView(view: SKView) {
        button = SKNode()
        self.addChild(button)
        
        let toggleSnowballSimulation = SKShapeNode(rect: CGRect(x: 400, y: 315, width: 70, height: 50), cornerRadius: 4)
        button.addChild(toggleSnowballSimulation)
        toggleSnowballSimulation.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        toggleSnowballSimulation.name = "RunButton"
        
        let toggleSnowballSimulationText = SKLabelNode(text: "Lever")
        toggleSnowballSimulationText.position = CGPoint(x: 85, y: 315)
        toggleSnowballSimulationText.fontSize = 20
        toggleSnowballSimulationText.fontColor = SKColor.darkGrayColor()
        toggleSnowballSimulationText.userInteractionEnabled = false
        toggleSnowballSimulation.addChild(toggleSnowballSimulationText)
    
        let toggleLeverSimulation = SKShapeNode(rect: CGRect(x: 50, y: 315, width: 70, height: 50), cornerRadius: 4)
        button.addChild(toggleLeverSimulation)
        toggleLeverSimulation.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        toggleLeverSimulation.name = "LeverRunButton"
        
        let toggleLeverSimulationText = SKLabelNode(text: "Ramp")
        toggleLeverSimulationText.position = CGPoint(x: 385, y: 315)
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
                    print(name)
                    
                    if name == "RunButton" {
                        gameViewController.startSnowballGame()
                    }
                    
                    if name == "LeverRunButton"{
                        gameViewController.startLeverGameNew()
                    }
                }
            }
        }
    }
}
    
