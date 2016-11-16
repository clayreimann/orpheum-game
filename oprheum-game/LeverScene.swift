//
//  LeverGameNew.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//

import SpriteKit

class LeverScene: BaseScene {
    static let runButtonName = "runButton"
    static let resetButtonName = "resetButton"
    static let smallWeightName = "smallWeight"
    static let largeWeightName = "largeWeight"

    var gameObjects: SKNode!
    var fulcrumNode: SKShapeNode!
    var instructionOverlay: SKNode!
    var movingFulcrum = false

    func buildInstructionOverlay() {
        instructionOverlay = SKNode()

        let background = SKShapeNode(rectOfSize: CGSize(width: 3000, height: 2000))
        background.fillColor = SKColor.blackColor()
        background.alpha = 0.25
        instructionOverlay.addChild(background)

        let instructions = SKLabelNode(text: "Move fulcrum for optimal drop")
        instructions.position = CGPoint(x: 500, y: 50)
        instructions.fontName = "Hoefler Text"
        instructions.fontSize = 25
        instructionOverlay.addChild(instructions)

        let instructionsPlay = SKLabelNode(text: "Choose the right drop weight to move the")
        instructionsPlay .position = CGPoint(x: 500, y: 370)
        instructionsPlay.fontName = "Hoefler Text"
        instructionOverlay.addChild(instructionsPlay)

        let instructionsPlay2 = SKLabelNode(text: "rock and help the princess into her castle!")
        instructionsPlay2 .position = CGPoint(x: 500, y: 330)
        instructionsPlay2.fontName = "Hoefler Text"
        instructionOverlay.addChild(instructionsPlay2)

        self.addChild(instructionOverlay)
    }

    func toggleSimulation() {
        if self.physicsWorld.speed == 0.0 {
            self.physicsWorld.speed = 1.0
        } else {
            self.physicsWorld.speed = 0.0
        }
    }

    func resetScene() {
        self.physicsWorld.speed = 0.0
        self.gameObjects.removeAllChildren()

        // Fulcrum triangle structure and instructions//
        let fulcrumPath = CGPathCreateMutable()
        CGPathMoveToPoint(fulcrumPath, nil, 25, 50)
        CGPathAddLineToPoint(fulcrumPath, nil, 0, 0)
        CGPathAddLineToPoint(fulcrumPath, nil, 50, 0)
        CGPathCloseSubpath(fulcrumPath)

        fulcrumNode = SKShapeNode(path: fulcrumPath)
        fulcrumNode.fillColor = SKColor(red: 0.675, green: 0.945, blue: 0.996, alpha: 1.00)
        fulcrumNode.physicsBody = SKPhysicsBody(polygonFromPath: fulcrumPath)
        fulcrumNode.physicsBody?.mass=100
        fulcrumNode.name = "fulcrumTriangle"
        fulcrumNode.position = CGPoint (x: 487, y: 0)
        gameObjects.addChild(fulcrumNode)

        // Fulcrum board structure and mass//
        let fulcrumBoardPath = CGPathCreateMutable()
        CGPathMoveToPoint(fulcrumBoardPath, nil, 0, 0)
        CGPathAddLineToPoint(fulcrumBoardPath, nil, 500, 0)
        CGPathAddLineToPoint(fulcrumBoardPath, nil, 500, 10)
        CGPathAddLineToPoint(fulcrumBoardPath, nil, 0, 10)
        CGPathCloseSubpath(fulcrumBoardPath)

        let fulcrumBoard = SKShapeNode(path: fulcrumBoardPath)
        fulcrumBoard.name = "fulcrumBoard"
        fulcrumBoard.fillColor = SKColor(red: 0.224, green: 0.855, blue: 0.847, alpha: 1)
        fulcrumBoard.physicsBody = SKPhysicsBody(polygonFromPath: fulcrumBoardPath)
        fulcrumBoard.physicsBody?.mass = 10
        fulcrumBoard.physicsBody?.friction = 1
        fulcrumBoard.position = CGPoint(x: 262, y: 50)
        gameObjects.addChild(fulcrumBoard)

        // Rock structure and mass//
        let rockPath = CGPathCreateMutable()
        CGPathMoveToPoint(rockPath, nil, -50, 0)
        CGPathAddLineToPoint(rockPath, nil, 50, 0)
        CGPathAddLineToPoint(rockPath, nil, 65, 45)
        CGPathAddLineToPoint(rockPath, nil, 0, 80)
        CGPathAddLineToPoint(rockPath, nil, -65, 45)
        CGPathCloseSubpath(rockPath)

        let rock = SKShapeNode(path: rockPath)
        rock.name = "rockthing"
        rock.fillColor = SKColor(red: 0.380, green: 0.380, blue: 0.380, alpha: 1.00)
        rock.physicsBody = SKPhysicsBody(polygonFromPath: rockPath)
        rock.physicsBody?.mass = 5
        rock.physicsBody?.friction = 1
        rock.physicsBody?.mass = 5

        let label = SKLabelNode(text: "5kg")
        rock.addChild(label)
        rock.position = CGPoint(x: 700, y: 60)

        gameObjects.addChild(rock)
    }

    // adds the weights tht will drop to fulcrum//
    func createWeight(mass: CGFloat) -> SKNode {
        let weight = SKNode()

        let weightBoxPath = CGPathCreateMutable()
        CGPathMoveToPoint(weightBoxPath, nil, -30, 0)
        CGPathAddLineToPoint(weightBoxPath, nil, 30, 0)
        CGPathAddLineToPoint(weightBoxPath, nil, 20, 40)
        CGPathAddLineToPoint(weightBoxPath, nil, -20, 40)
        CGPathCloseSubpath(weightBoxPath)

        let weightBox = SKShapeNode(path: weightBoxPath)
        weightBox.name = "weightBox"
        weightBox.fillColor = SKColor(red: 0.132, green: 0.424, blue: 0.620, alpha: 1.00)
        weightBox.physicsBody = SKPhysicsBody(polygonFromPath: weightBoxPath)
        weightBox.physicsBody?.mass = mass
        weightBox.physicsBody?.friction = 1
        weight.addChild(weightBox)

        let label = SKLabelNode(text: String(format: "%.0fkg", mass))
        weightBox.addChild(label)

        return weight
    }

    override func didMoveToView(view: SKView) {
        self.gameObjects = SKNode()
        self.addChild(gameObjects)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.name = "BouncingBalls"

        let startStopButton = createButton(named: LeverScene.runButtonName, text: "Run/Pause",
                                                atPoint: CGPoint(x: 950, y: 715), withSize: BaseScene.smallButtonSize)
        self.addChild(startStopButton)

        let resetButton = createButton(named: LeverScene.resetButtonName, text: "Reset",
                                            atPoint: CGPoint(x: 950, y: 640), withSize: BaseScene.smallButtonSize)
        self.addChild(resetButton)

        let smallWeigthButton = createButton(named: LeverScene.smallWeightName, text: "5kg",
                                                  atPoint: CGPoint(x: 950, y: 565), withSize: BaseScene.smallButtonSize)
        self.addChild(smallWeigthButton)

        let largeWeightButton = createButton(named: LeverScene.largeWeightName, text: "10kg",
                                                  atPoint: CGPoint(x: 950, y: 490), withSize: BaseScene.smallButtonSize)
        self.addChild(largeWeightButton)

        let mainMenuButton = createSmallButton(named: "mainMenu", text: "Menu",
                                               atPoint: CGPoint(x: 950, y: 415), withSize: BaseScene.smallButtonSize)
        self.addChild(mainMenuButton)

        buildInstructionOverlay()

        resetScene()
    }


    func runButtonTouched(touch: NSValue) -> Bool {
        toggleSimulation()
        return true // stop processing touches
    }

    func resetButtonTouched(touch: NSValue) -> Bool {
        resetScene()

        let showInstructionsAction = SKAction.fadeInWithDuration(0.3)
        instructionOverlay.runAction(showInstructionsAction)
        return true // stop processing touches
    }

    func smallWeightTouched(touch: NSValue) -> Bool {
        let weight = createWeight(5)
        weight.position = CGPoint(x: 365, y: 300)
        gameObjects.addChild(weight)

        return true // stop processing touches
    }

    func largeWeightTouched(touch: NSValue) -> Bool {
        let weight = createWeight(10)
        weight.position = CGPoint(x: 365, y: 300)
        gameObjects.addChild(weight)

        return true // stop processing touches
    }

    func mainMenuTouched(touch: NSValue) -> Bool {
            gameViewController.startMenu()
            return true
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = self.nodesAtPoint(location)
            for node in nodes {
                if let name = node.name where name == "fulcrumTriangle" {
                    movingFulcrum = true
                    return
                }
            }
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)

        if instructionOverlay.alpha == 1 {
            let hideInstructionsAction = SKAction.fadeOutWithDuration(0.3)
            instructionOverlay.runAction(hideInstructionsAction)
        }

        movingFulcrum = false
    }

    // controls the movement of the fulcrum triangle//
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard movingFulcrum else { return }

        for touch in touches {
            let location = touch.locationInNode(self)
            let newPosition = CGPoint(x: location.x, y: 0)
            fulcrumNode.position = newPosition
            print("%@", touch)
        }
    }

}
