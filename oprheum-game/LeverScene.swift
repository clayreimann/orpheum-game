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
    var movingFulcrum = false

    func buildInstructionOverlay() {
        instructionOverlay = InstructionOverlayNode(scene: self)
        instructionOverlay.text1 = "Move fulcrum for optimal drop"
        instructionOverlay.text2 = "Choose the right drop weight to move the\nrock and help the princess into her castle"
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
        let fulcrumPath = CGMutablePath()
        fulcrumPath.move(to: CGPoint(x: 25, y: 50))
        fulcrumPath.addLine(to: CGPoint(x: 0, y: 0))
        fulcrumPath.addLine(to: CGPoint(x: 50, y: 0))
        fulcrumPath.closeSubpath()

        fulcrumNode = SKShapeNode(path: fulcrumPath)
        fulcrumNode.fillColor = SKColor(red: 0.675, green: 0.945, blue: 0.996, alpha: 1.00)
        fulcrumNode.physicsBody = SKPhysicsBody(polygonFrom: fulcrumPath)
        fulcrumNode.physicsBody?.mass=100
        fulcrumNode.name = "fulcrumTriangle"
        fulcrumNode.position = CGPoint (x: 487, y: 0)
        gameObjects.addChild(fulcrumNode)

        // Fulcrum board structure and mass//
        let fulcrumBoardPath = CGMutablePath()
        fulcrumBoardPath.move(to: CGPoint(x: 0, y: 0))
        fulcrumBoardPath.addLine(to: CGPoint(x: 500, y: 0))
        fulcrumBoardPath.addLine(to: CGPoint(x: 500, y: 10))
        fulcrumBoardPath.addLine(to: CGPoint(x: 0, y: 10))
        fulcrumBoardPath.closeSubpath()

        let fulcrumBoard = SKShapeNode(path: fulcrumBoardPath)
        fulcrumBoard.name = "fulcrumBoard"
        fulcrumBoard.fillColor = SKColor(red: 0.224, green: 0.855, blue: 0.847, alpha: 1)
        fulcrumBoard.physicsBody = SKPhysicsBody(polygonFrom: fulcrumBoardPath)
        fulcrumBoard.physicsBody?.mass = 10
        fulcrumBoard.physicsBody?.friction = 1
        fulcrumBoard.position = CGPoint(x: 262, y: 50)
        gameObjects.addChild(fulcrumBoard)

        //Castle square shape//
        let castleShapePath = CGMutablePath()
        castleShapePath.move(to: CGPoint(x: 500, y: 0))
        castleShapePath.addLine(to: CGPoint(x: 500, y: 300))
        castleShapePath.addLine(to: CGPoint(x: 674, y: 300))
        castleShapePath.addLine(to: CGPoint(x: 674, y: 0))
        castleShapePath.closeSubpath()

        let castleShape = SKShapeNode(path: castleShapePath)
        castleShape.name = "Castle shape"
        castleShape.fillColor = SKColor(red: 0.224, green: 1, blue: 0.847, alpha: 1)
        castleShape.physicsBody = SKPhysicsBody(polygonFrom: castleShapePath)
        castleShape.physicsBody?.mass = 10
        castleShape.physicsBody?.friction = 1
        castleShape.position = CGPoint(x: 350, y: 0)
        gameObjects.addChild(castleShape)

        // Rock structure and mass//
        let rockPath = CGMutablePath()
        rockPath.move(to: CGPoint(x: -50, y: 0))
        rockPath.addLine(to: CGPoint(x: 50, y: 0))
        rockPath.addLine(to: CGPoint(x: 65, y: 45))
        rockPath.addLine(to: CGPoint(x: 0, y: 80))
        rockPath.addLine(to: CGPoint(x: -65, y: 45))
        rockPath.closeSubpath()

        let rock = SKShapeNode(path: rockPath)
        rock.name = "rockthing"
        rock.fillColor = SKColor(red: 0.380, green: 0.380, blue: 0.380, alpha: 1.00)
        rock.physicsBody = SKPhysicsBody(polygonFrom: rockPath)
        rock.physicsBody?.mass = 20
        rock.physicsBody?.friction = 1
        rock.physicsBody?.mass = 20

        let label = SKLabelNode(text: "20kg")
        rock.addChild(label)
        rock.position = CGPoint(x: 700, y: 60)

        gameObjects.addChild(rock)
    }

    // adds the weights tht will drop to fulcrum//
    func createWeight(_ mass: CGFloat) -> SKNode {
        let weight = SKNode()

        let weightBoxPath = CGMutablePath()
        weightBoxPath.move(to: CGPoint(x: -30, y: 0))
        weightBoxPath.addLine(to: CGPoint(x: 30, y: 0))
        weightBoxPath.addLine(to: CGPoint(x: 20, y: 40))
        weightBoxPath.addLine(to: CGPoint(x: -20, y: 40))
        weightBoxPath.closeSubpath()

        let weightBox = SKShapeNode(path: weightBoxPath)
        weightBox.name = "weightBox"
        weightBox.fillColor = SKColor(red: 0.132, green: 0.424, blue: 0.620, alpha: 1.00)
        weightBox.physicsBody = SKPhysicsBody(polygonFrom: weightBoxPath)
        weightBox.physicsBody?.mass = mass
        weightBox.physicsBody?.friction = 1
        weight.addChild(weightBox)

        let label = SKLabelNode(text: String(format: "%.0fkg", mass))
        weightBox.addChild(label)

        return weight
    }

    override func didMove(to view: SKView) {
        self.gameObjects = SKNode()
        self.addChild(gameObjects)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.name = "BouncingBalls"

        let startStopButton = createSmallButton(named: LeverScene.runButtonName, text: "Run/Pause",
                                                atPoint: CGPoint(x: 950, y: 715), withSize: BaseScene.smallButtonSize)
        self.addChild(startStopButton)

        let resetButton = createSmallButton(named: LeverScene.resetButtonName, text: "Reset",
                                            atPoint: CGPoint(x: 950, y: 640), withSize: BaseScene.smallButtonSize)
        self.addChild(resetButton)

        let smallWeigthButton = createSmallButton(named: LeverScene.smallWeightName, text: "5kg",
                                                  atPoint: CGPoint(x: 950, y: 565), withSize: BaseScene.smallButtonSize)
        self.addChild(smallWeigthButton)

        let largeWeightButton = createSmallButton(named: LeverScene.largeWeightName, text: "10kg",
                                                  atPoint: CGPoint(x: 950, y: 490), withSize: BaseScene.smallButtonSize)
        self.addChild(largeWeightButton)

        let mainMenuButton = createSmallButton(named: "mainMenu", text: "Menu",
                                               atPoint: CGPoint(x: 950, y: 415), withSize: BaseScene.smallButtonSize)
        self.addChild(mainMenuButton)

        buildInstructionOverlay()

        resetScene()
    }

    func runButtonTouched(_ touch: NSValue) -> Bool {
        toggleSimulation()
        return true // stop processing touches
    }

    func resetButtonTouched(_ touch: NSValue) -> Bool {
        resetScene()

        let showInstructionsAction = SKAction.fadeIn(withDuration: 0.3)
        instructionOverlay.run(showInstructionsAction)
        return true // stop processing touches
    }

    func smallWeightTouched(_ touch: NSValue) -> Bool {
        let weight = createWeight(5)
        weight.position = CGPoint(x: 365, y: 300)
        gameObjects.addChild(weight)

        return true // stop processing touches
    }

    func largeWeightTouched(_ touch: NSValue) -> Bool {
        let weight = createWeight(10)
        weight.position = CGPoint(x: 365, y: 300)
        gameObjects.addChild(weight)

        return true // stop processing touches
    }

    func mainMenuTouched(_ touch: NSValue) -> Bool {
            gameViewController.startMenu()
            return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            for node in nodes {
                if let name = node.name, name == "fulcrumTriangle" {
                    movingFulcrum = true
                    return
                }
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        if instructionOverlay.alpha == 1 {
            let hideInstructionsAction = SKAction.fadeOut(withDuration: 0.3)
            instructionOverlay.run(hideInstructionsAction)
        }

        movingFulcrum = false
    }

    // controls the movement of the fulcrum triangle//
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard movingFulcrum else { return }

        for touch in touches {
            let location = touch.location(in: self)
            let newPosition = CGPoint(x: location.x, y: 0)
            fulcrumNode.position = newPosition
            print("%@", touch)
        }
    }
}
