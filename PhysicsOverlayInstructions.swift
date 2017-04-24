//  PhysicsOverlayInstructions.swift
//  orpheum-game
//
//  Created by Yichen Yao on 4/2/17.

import SpriteKit

class SnowballGamePhysics: SKShapeNode {
    override init() {
        super.init()

        let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 1800, height: 1800), cornerRadius: 5)
        node.fillColor = SKColor.lightGray
        self.addChild(node)

        let exitInstructionsButton = ButtonNode(name: "exitInstructionsButton", text: "X", size: CGSize(width: 60, height: 60))
        exitInstructionsButton.cornerRadius = 30
        exitInstructionsButton.position = CGPoint(x: 965, y: 700)
        node.addChild(exitInstructionsButton)

        let instructions = InstructionOverlayNode(size: CGSize(width: 400, height: 400))
        instructions.text1 =
            "In physics, a tilted surface, or ramp, is called an inclined plane. \n\n" +
            "The rate at which a ball will roll down an inclined plane \n" +
            "depends on how tilted the surface is. \n" +
            "The greater the tilt, the faster the object will roll down.\n\n" +
            "Balls accelerate down inclined planes due to gravitational and normal forces.\n" +
            "Gravity acts downward, while normal force acts perpendicularly."
        instructions.position = CGPoint(x: 350, y: 100)
        self.addChild(instructions)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
