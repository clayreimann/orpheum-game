//
//  SnowballMenu.swift
//  orpheum-game
//
//  Created by Yichen Yao on 10/17/16.
//
//easy, medium, hard, main menu, back

import SpriteKit
var button: SKNode?
class SnowballMenu: SKNode {
    override init() {

        super.init()
        let node = SKShapeNode(rect: CGRect(x: 300, y: 100, width: 400, height: 600), cornerRadius: 5)
        node.fillColor = SKColor.grayColor()
        self.addChild(node)
    
        let easyButton = SKShapeNode(rect: CGRect(x: 420, y: 570, width: 130, height: 90), cornerRadius: 4)
        node.addChild(easyButton)
        easyButton.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        easyButton.name = "EasyButton"

        let easyButtonLabel = SKLabelNode(text: "Easy")
        easyButtonLabel.position = CGPoint(x: 445, y: 570)
        easyButtonLabel.fontSize = 20
        easyButtonLabel.fontColor = SKColor.darkGrayColor()
        easyButtonLabel.userInteractionEnabled = false
        easyButton.addChild(easyButtonLabel)
        
        let mediumButton = SKShapeNode(rect: CGRect(x: 420, y: 455, width: 130, height: 90), cornerRadius: 4)
        node.addChild(mediumButton)
        mediumButton.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        mediumButton.name = "MediumButton"
        
        let mediumButtonLabel = SKLabelNode(text: "Medium")
        mediumButtonLabel.position = CGPoint(x: 485, y: 455)
        mediumButtonLabel.fontSize = 20
        mediumButtonLabel.fontColor = SKColor.darkGrayColor()
        mediumButtonLabel.userInteractionEnabled = false
        mediumButton.addChild(mediumButtonLabel)
        
        let hardButton = SKShapeNode(rect: CGRect(x: 420, y: 355, width: 130, height: 90), cornerRadius: 4)
        node.addChild(hardButton)
        hardButton.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        hardButton.name = "HardButton"
        
        let hardButtonLabel = SKLabelNode(text: "Hard")
        hardButtonLabel.position = CGPoint(x: 485, y: 355)
        hardButtonLabel.fontSize = 20
        hardButtonLabel.fontColor = SKColor.darkGrayColor()
        hardButtonLabel.userInteractionEnabled = false
        hardButton.addChild(hardButtonLabel)
        
        let backToMenuButton = SKShapeNode(rect: CGRect(x: 420, y: 155, width: 130, height: 90), cornerRadius: 4)
        node.addChild(backToMenuButton)
        backToMenuButton.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        backToMenuButton.name = "backToMenuButton"
        
        let backToMenuButtonLabel = SKLabelNode(text: "Main Menu")
        backToMenuButtonLabel.position = CGPoint(x: 485, y: 155)
        backToMenuButtonLabel.fontSize = 20
        backToMenuButtonLabel.fontColor = SKColor.darkGrayColor()
        backToMenuButtonLabel.userInteractionEnabled = false
        backToMenuButton.addChild(backToMenuButtonLabel)
        
        let exitButton = SKShapeNode(circleOfRadius: 30)
        exitButton.position = CGPoint(x: 695, y: 700)
        node.addChild(exitButton)
        exitButton.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        exitButton.name = "exitButton"
        
        let exitButtonLabel = SKLabelNode(text: "X")
        exitButtonLabel.position = CGPoint(x: 695, y: 700)
        exitButtonLabel.fontSize = 30
        exitButtonLabel.fontColor = SKColor.darkGrayColor()
        exitButtonLabel.userInteractionEnabled = false
        exitButton.addChild(exitButtonLabel)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let nodes = self.nodesAtPoint(touch.locationInNode(self))
            for node in nodes {
                if node.name == "exitButton" {
                    self.removeFromParent()
                }
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
