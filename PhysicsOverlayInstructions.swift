//
//  PhysicsOverlayInstructions.swift
//  orpheum-game
//
//  Created by Yichen Yao on 4/2/17.
//
//

import SpriteKit

class SnowballGamePhysics: SKShapeNode {
    override init() {
        super.init()
        
        let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 1800, height: 1800), cornerRadius: 5)
        node.fillColor = SKColor.lightGrayColor()
        self.addChild(node)
        
        let exitInstructionsButton = ButtonNode(name: "exitInstructionsButton", text: "X", size: CGSize(width: 60, height: 60))
        exitInstructionsButton.cornerRadius = 30
        exitInstructionsButton.position = CGPoint(x: 965, y: 700)
        node.addChild(exitInstructionsButton)

        let instructions = InstructionOverlayNode(size: CGSize(width: 400, height: 400))
        instructions.text1 = "The rate at which a ball will roll down a tilted surface depends\n" +
            "on how tilted the surface is. The greater the tilt of the surface, the faster the rate\n" +
            "at which the object will slide down it. In physics, a tilted surface is called an inclined\n" +
            "plane. Balls accelerate down inclined planes because of forces. These forces are gravity\n" +
            "and normal force. Gravity acts downward, while normal force acts perpendicular"
        instructions.position = CGPoint(x: 200, y: 200)
        self.addChild(instructions)
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
