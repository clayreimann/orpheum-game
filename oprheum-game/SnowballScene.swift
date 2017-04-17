//
//  GameScene.swift
// make menu difficulty buttons do something, back to main main menu
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.

import SpriteKit

class SnowballScene: BaseScene {
    static let runButtonName = "RunButton"
    static let resetButtonName = "ResetButton"
    static let menuButtonName = "MenuButton"
    static let physicsInstructionsName = "physicsInstructionsButton"
    static let timeresetButtonName = "TimeResetButton"

    var difficulty: CGFloat = 0.5

    var selectedNode: SKNode?

    var buttons: SKNode!

    var gameObjects: SKNode!
    var snowballNode: SnowballNode!
    var rampNode: RampNode!
    var monster: SKSpriteNode!

    var internalOverlay: SKNode!

    var previousDegrees: Int = 0
    var timerValue: SKLabelNode!
    var start: Date?
    var timeRemaining = 30.0
    var level = 30.0

    var snowballMenu: SnowballMenu!
    var physicsInstructions: SnowballGamePhysics!

    func stopSimulation() {
        self.physicsWorld.speed = 0.0
        startTimer()
    }

    func startSimulation() {
        self.physicsWorld.speed = 1.0
        stopTimer()
    }

    func startTimer() {
        start = Date()
    }

    func stopTimer() {
        if let start = start {
            let delta = start.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
            timeRemaining = timeRemaining + delta
        }
        start = nil
    }

    func buildInstructionOverlay() {
        instructionOverlay = InstructionOverlayNode(scene: self)
        instructionOverlay.text1 = "Use the snowball and ramp to try and\nknock the monster down with the snowball"
        instructionOverlay.text2 = "Tap on the ramp or the snowball to select them then pinch to resize"
        instructionOverlay.text3 = "Tap to continue"
        self.addChild(instructionOverlay)
    }

    func buildWinOverlay() {
        self.addChild(winOverlay)
    }

    func showWinOverlay() {
        timerValue.alpha = 0
        winOverlay.show()
        let hideObjects = SKAction.fadeOut(withDuration: 0.3)
        gameObjects.run(hideObjects)
    }

    func hideWinOverlay() {
        timerValue.alpha = 1
        winOverlay.hide()
        let showObjects = SKAction.fadeIn(withDuration: 0.3)
        gameObjects.run(showObjects)
    }

    func isGameWon() -> Bool {
        return winOverlay.alpha > 0.5
    }

    func buildLoseOverlay() {
       self.addChild(loseOverlay)
    }

    func showLoseOverlay() {
        instructionOverlay.alpha = 0
        timerValue.alpha = 0
        loseOverlay.show()
        let hideSceneAction = SKAction.fadeOut(withDuration: 0.3)
        gameObjects.run(hideSceneAction)

        start = nil
    }

    func hideLoseOverlay() {
        timerValue.alpha = 1
        loseOverlay.hide()
        let showSceneAction = SKAction.fadeIn(withDuration: 0.3)
        gameObjects.run(showSceneAction)
    }

    func isGameLost() -> Bool {
        return loseOverlay.alpha == 1
    }

    func resetScene() {

        hideWinOverlay()
        hideLoseOverlay()

        snowballNode.position = CGPoint(x: 70, y: self.frame.height - 70)
        snowballNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        snowballNode.zPosition = 0

        monster.position = CGPoint(x: 700, y: monster.size.height/2)
        monster.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        monster.zRotation = 0
    }

    override func didMove(to view: SKView) {
        self.gameObjects = SKNode()
        self.addChild(gameObjects)
        self.physicsWorld.speed = 0.0
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.name = "BouncingBalls"
        buttons = SKNode()
        buttons.position = CGPoint(x: 900, y: 400)
        buttons.zPosition = 100
        self.addChild(buttons)

        let pinchRecognzier = UIPinchGestureRecognizer(target: self, action: #selector(SnowballScene.handlePinchGesture(_:)))
        self.view?.addGestureRecognizer(pinchRecognzier)

        let toggleSimulation = createSmallButton(named: SnowballScene.runButtonName, text: "Run", atPoint: CGPoint(x: 80, y: 330), withSize: BaseScene.smallButtonSize)
        buttons.addChild(toggleSimulation)

        let resetButton = createSmallButton(named: SnowballScene.resetButtonName, text: "Reset", atPoint: CGPoint(x: 80, y: 265), withSize: BaseScene.smallButtonSize)
        buttons.addChild(resetButton)

        let timeresetButton = createSmallButton(named: SnowballScene.timeresetButtonName, text: "Timer Reset", atPoint: CGPoint(x: 80, y: 200), withSize: BaseScene.smallButtonSize)
        buttons.addChild(timeresetButton)

        let menuButton = createSmallButton(named: SnowballScene.menuButtonName, text: "Menu", atPoint: CGPoint(x: 80, y: 135), withSize: BaseScene.smallButtonSize)
        buttons.addChild(menuButton)

        let physicsInstructions = createSmallButton(named: SnowballScene.physicsInstructionsName, text: "?", atPoint: CGPoint(x: 80, y: 20), withSize: BaseScene.smallButtonSize)
        buttons.addChild(physicsInstructions)

        timerValue = SKLabelNode(text: "0")
        timerValue.fontColor = SKColor.white
        timerValue.position = CGPoint(x: 550, y: 700)
        timerValue.fontSize = 60
        timerValue.zPosition = 100
        self.addChild(timerValue)

        monster = SKSpriteNode(imageNamed: "Monster")
        monster.name = "monster"
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size)
        monster.physicsBody?.mass = 0.5
        gameObjects.addChild(monster)

        rampNode = RampNode()
        gameObjects.addChild(rampNode)

        snowballNode = SnowballNode()
        gameObjects.addChild(snowballNode)

        buildInstructionOverlay()
        buildLoseOverlay()
        buildWinOverlay()
        resetScene()
    }

    func unselectAll() {
        rampNode.unselect()
        snowballNode.unselect()
        selectedNode = nil
    }

    func addGameObjectsToScene() {
        self.addChild(rampNode)
        self.addChild(snowballNode)
        self.addChild(buttons)
        self.addChild(monster)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if instructionOverlay.alpha != 0 {
                self.stopSimulation()
                let hideInstructionsAction = SKAction.fadeOut(withDuration: 0.3)
                instructionOverlay.run(hideInstructionsAction)
                startTimer()
            }

            if isGameLost() {
                hideLoseOverlay()
                stopSimulation()
                addGameObjectsToScene()
                resetScene()
                timeRemaining = level
                return
            }

            let hideWinInstructionsAction = SKAction.fadeOut(withDuration: 0.3)
            instructionOverlay.run(hideWinInstructionsAction)

            if isGameWon() {
                hideWinOverlay()
                addGameObjectsToScene()
                stopSimulation()
                resetScene()
                timeRemaining = level
                return
            }

            let nodes = self.nodes(at: touch.location(in: self))
            for node in nodes {
                if let ramp = node as? RampNode {
                    unselectAll()
                    ramp.select()
                    selectedNode = ramp
                    return
                }
                if let snowballNode = node as? SnowballNode {
                    unselectAll()
                    snowballNode.select()
                    selectedNode = snowballNode
                    return
                }

                if let name = node.name {
                    print(name)

                    if name == "RunButton" {
                        resetScene()
                        startSimulation()
                    } else if name == "ResetButton" {
                        stopSimulation()
                        resetScene()

                    } else if name == "TimeResetButton" {
                       stopSimulation()
                       resetScene ()
                        timerValue.alpha = 30

                    } else if name == "MenuButton" {
                        start = nil
                        timerValue.alpha = 0
                        rampNode.removeFromParent()
                        snowballNode.removeFromParent()
                        buttons.removeFromParent()
                        monster.removeFromParent()
                        snowballMenu = SnowballMenu()
                        self.addChild(snowballMenu)
                    } else if node.name == "EasyButton" {
                        stopSimulation()
                        addGameObjectsToScene()
                        rampNode.maxSize = RampNode.easyMaximumSize
                        snowballMenu.removeFromParent()
                        resetScene()
                        timeRemaining = 30
                        level = 30
                    } else if node.name == "MediumButton" {
                        stopSimulation()
                        addGameObjectsToScene()
                        rampNode.maxSize = RampNode.mediumMaximumSize
                        snowballMenu.removeFromParent()
                        resetScene()
                        timeRemaining = 20
                        level = 20
                        timerValue.alpha = 1
                    } else if node.name == "HardButton" {
                        self.stopSimulation()
                        addGameObjectsToScene()
                        rampNode.maxSize = RampNode.hardMaximumSize
                        snowballMenu.removeFromParent()
                        resetScene()
                        timeRemaining = 10
                        level = 10
                        timerValue.alpha = 1
                    } else if node.name == "exitButton" {
                        addGameObjectsToScene()
                        snowballMenu.removeFromParent()
                        timerValue.alpha = 1
                    } else if node.name == "backToMenuButton" {
                        gameViewController.startMenu()
                    } else if node.name == "physicsInstructionsButton" {
                        start = nil
                        timerValue.alpha = 0
                        rampNode.removeFromParent()
                        snowballNode.removeFromParent()
                        buttons.removeFromParent()
                        monster.removeFromParent()
                        physicsInstructions = SnowballGamePhysics()
                        self.addChild(physicsInstructions)
                    } else if node.name == "exitInstructionsButton" {
                        addGameObjectsToScene()
                        physicsInstructions.removeFromParent()
                        timerValue.alpha = 1
                    }
                }
            }
        }
    }

    func handlePinchGesture(_ recognizer: UIPinchGestureRecognizer) {
        let touch1 = recognizer.location(ofTouch: 0, in: self.view!)
        let touch2 = recognizer.location(ofTouch: 1, in: self.view!)

        if recognizer.state == UIGestureRecognizerState.began {
            if let ramp = selectedNode as? RampNode {
                ramp.pinchBegan(touch1, touch2: touch2)
            }
            if let snowball = selectedNode as? SnowballNode {
                snowball.pinchBegan(recognizer.scale)
            }
        } else if recognizer.state == UIGestureRecognizerState.changed {
            if let ramp = selectedNode as? RampNode {
                ramp.pinchChanged(touch1, touch2: touch2)
            }
            if let snowball = selectedNode as? SnowballNode {
                snowball.pinchChanged(recognizer.scale)
            }
        } else if recognizer.state == UIGestureRecognizerState.ended {
            if let ramp = selectedNode as? RampNode {
                ramp.pinchEnded(touch1, touch2: touch2)
            }
            if let snowball = selectedNode as? SnowballNode {
                snowball.pinchEnded(recognizer.scale)
            }
        }
    }

    func redrawBall() {
        snowballNode.redrawSnowball()
    }

    func changeBallMass() {
        snowballNode.setSnowballMass(25)
    }

    override func update(_ currentTime: TimeInterval) {
        if let monster = monster {
            let π = CGFloat.pi
            let degrees = abs((monster.zRotation * 180 / π).truncatingRemainder(dividingBy: 360))

            if degrees > 75 && 255 > degrees {
                let degrees = previousDegrees
                if degrees == previousDegrees {
                    showWinOverlay()
                    rampNode.removeFromParent()
                    snowballNode.removeFromParent()
                    buttons.removeFromParent()
                    monster.removeFromParent()
                    stopSimulation()
                } else if previousDegrees == degrees {
                    unselectAll()
                }
                print(degrees)
            }
            if let start = start {
                let interval = Date().timeIntervalSince(start)
                if interval > timeRemaining {
                    rampNode.removeFromParent()
                    snowballNode.removeFromParent()
                    buttons.removeFromParent()
                    monster.removeFromParent()
                    showLoseOverlay()
                    stopSimulation()
                }
                timerValue.text = String(format: "%.1f", (timeRemaining - interval))
            }
        }
    }

}
