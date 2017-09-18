//
//  LeverGameNew.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//
import SpriteKit

class LeverScene: BaseScene {
    public static let initialMass: CGFloat = 5
    static let runButtonName = "runButton"
    static let resetButtonName = "resetButton"
    static let addWeightName = "addWeight"
    var weight: CGFloat = 0
    var gameObjects: SKNode!
    var fulcrumNode: SKShapeNode!
    var weightBox: SKShapeNode!
    var movingFulcrum = false
    var mass: CGFloat = 0
    var mass0: CGFloat = 0
    
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
        
        let weightBoxPath = CGMutablePath()
        weightBoxPath.move(to: CGPoint(x: 550, y: 400))
        weightBoxPath.addLine(to: CGPoint(x: 600, y: 400))
        weightBoxPath.addLine(to: CGPoint(x: 630, y: 350))
        weightBoxPath.addLine(to: CGPoint(x: 520, y: 350))
        weightBoxPath.closeSubpath()
    
        let weightBox = SKShapeNode(path: weightBoxPath)
        weightBox.name = "weightBox"
        weightBox.fillColor = SKColor(red: 0.132, green: 0.424, blue: 0.620, alpha: 1.00)
        weightBox.physicsBody = SKPhysicsBody(polygonFrom: weightBoxPath)
        weightBox.physicsBody?.mass = mass
        weightBox.physicsBody?.friction = 1
        gameObjects.addChild(weightBox)
        
        let label = SKLabelNode(text: String(format: "%.0fkg", weightBox.physicsBody!.mass))
        weightBox.addChild(label)
        
        // Fulcrum triangle structure and instructions//
        let fulcrumPath = CGMutablePath()
        fulcrumPath.move(to: CGPoint(x: 15, y: 35))
        fulcrumPath.addLine(to: CGPoint(x: 0, y: 0))
        fulcrumPath.addLine(to: CGPoint(x: 35, y: 0))
        fulcrumPath.closeSubpath()
        
        fulcrumNode = SKShapeNode(path: fulcrumPath)
        fulcrumNode.fillColor = SKColor(red: 0.675, green: 0.945, blue: 0.996, alpha: 1.00)
        fulcrumNode.physicsBody = SKPhysicsBody(polygonFrom: fulcrumPath)
        fulcrumNode.physicsBody?.mass=100
        fulcrumNode.name = "fulcrumTriangle"
        fulcrumNode.position = CGPoint (x: 650, y: 0)
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
        fulcrumBoard.position = CGPoint(x: 520, y: 35)
        gameObjects.addChild(fulcrumBoard)
        
        //Castle square shape//
        let castleShapePath = CGMutablePath()
        castleShapePath.move(to: CGPoint(x: 0, y: 0))
        castleShapePath.addLine(to: CGPoint(x: 0, y: 700))
        castleShapePath.addLine(to: CGPoint(x: 130, y: 700))
        castleShapePath.addLine(to: CGPoint(x: 130, y: 0))
        castleShapePath.closeSubpath()
        
        let castleShape = SKShapeNode(path: castleShapePath)
        castleShape.name = "Castle shape"
        castleShape.fillColor = SKColor(red: 0.224, green: 1, blue: 0.847, alpha: 1)
        castleShape.physicsBody = SKPhysicsBody(polygonFrom: castleShapePath)
        castleShape.physicsBody?.mass = 1000
        castleShape.physicsBody?.friction = 1
        castleShape.position = CGPoint(x: 0, y: 0)
        gameObjects.addChild(castleShape)
        
        let castleWindowShapePath = CGMutablePath()
        castleWindowShapePath.move(to: CGPoint(x: 30, y: 500))
        castleWindowShapePath.addLine(to: CGPoint(x: 30, y: 600))
        castleWindowShapePath.addLine(to: CGPoint(x: 100, y: 600))
        castleWindowShapePath.addLine(to: CGPoint(x: 100, y: 500))
        castleWindowShapePath.closeSubpath()
        
        let castleWindowShape = SKShapeNode(path: castleWindowShapePath)
        castleWindowShape.name = "Castle shape"
        castleWindowShape.fillColor = SKColor(red: 0.224, green: 0, blue: 0.847, alpha: 1)
        castleWindowShape.position = CGPoint(x: 0, y: 0)
        gameObjects.addChild(castleWindowShape)
        
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
        rock.physicsBody?.mass = 10
        rock.physicsBody?.friction = 1
        
        let rockLabel = SKLabelNode(text: "10kg")
        rockLabel.position = CGPoint(x:950, y: 65)
        rock.addChild(rockLabel)
        rock.position = CGPoint(x: 950, y: 45)
        
        gameObjects.addChild(rock)
    }
    func addWeight (){
        let newMass = mass + 10
        weightBox.physicsBody?.mass = newMass   
    }

    func showWinOverlay() {
        winOverlay.show()
    }
    
    override func didMove(to view: SKView) {
        self.gameObjects = SKNode()
        self.addChild(gameObjects)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.name = "BouncingBalls"
        
        let startStopButton = ButtonNode(name: LeverScene.runButtonName, text: "Run/Pause", size: BaseScene.smallButtonSize)
        startStopButton.position = CGPoint(x: 950, y: 715)
        self.addChild(startStopButton)
        
        let resetButton = ButtonNode(name: LeverScene.resetButtonName, text: "Reset", size: BaseScene.smallButtonSize)
        resetButton.position = CGPoint(x: 950, y: 640)
        self.addChild(resetButton)
        
        let addWeightButton = ButtonNode(name: LeverScene.addWeightName, text: "+50kg", size: BaseScene.smallButtonSize)
        addWeightButton.position = CGPoint(x: 950, y: 565)
        self.addChild(addWeightButton)
        
        let mainMenuButton = ButtonNode(name: "mainMenu", text: "Menu", size: BaseScene.smallButtonSize)
        mainMenuButton.position = CGPoint(x: 950, y: 415)
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
    
    func addWeightButtonTouched(_ touch: NSValue) -> Bool {
        addWeight()
        return true
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
