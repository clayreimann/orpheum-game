//
//  GameScene.swift
// make menu difficulty buttons do something, back to main main menu
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.

import SpriteKit

class SnowballScene: BaseScene {
    static let runButtonName = "RunButton"
    static let resetButtonName = "ResetButton"
    static let menuButtonName = "MenuButton"

    var difficulty: CGFloat = 0.5

    var selectedNode: SKNode?

    var buttons: SKNode!

    var gameObjects: SKNode!
    var snowballNode: SnowballNode!
    var rampNode: RampNode!
    var monster: SKSpriteNode!

    var winOverlay: SKNode!
    var loseOverlay: SKNode!

    var previousDegrees: Int = 0
    var timerValue: SKLabelNode!
    var start: NSDate?
    var timeRemaining = 30.0

    var snowballMenu: SnowballMenu!

    func stopSimulation() {
        self.physicsWorld.speed = 0.0
        startTimer()
    }

    func startSimulation() {
        self.physicsWorld.speed = 1.0
        stopTimer()
    }

    func startTimer() {
        start = NSDate()
    }

    func stopTimer() {
        if let start = start {
            let delta = start.timeIntervalSinceReferenceDate - NSDate().timeIntervalSinceReferenceDate
            timeRemaining = timeRemaining + delta
        }
        start = nil
    }

    func buildInstructionOverlay() {
        instructionOverlay = InstructionOverlayNode(scene: self)
        instructionOverlay.text1 = "Use the snowball and ramp to try and\nknock the monster down with the snowball"
        instructionOverlay.text2 = "Tap on the ramp or the snowball to select them then pinch to resize"
        self.addChild(instructionOverlay)
    }

    func buildWinOverlay() {
        timerValue.alpha = 1
        winOverlay = SKNode()
        winOverlay.alpha = 0

        let background = SKShapeNode(rectOfSize: CGSize(width: 3000, height: 2000))
        background.fillColor = SKColor.darkGrayColor()
        background.alpha = 0.25
        winOverlay.addChild(background)

        let winScreen = SKLabelNode(text: "You Win!")
        winScreen.position = CGPoint(x: 500, y: 400)
        winScreen.fontName = "Hoefler Text"
        winScreen.fontSize = 75
        winOverlay.addChild(winScreen)
        self.addChild(winOverlay)
    }

    func showWinOverlay() {
        timerValue.alpha = 0
        let showWinOverlayAction = SKAction.fadeInWithDuration(0.3)
        winOverlay.runAction(showWinOverlayAction)
        let hideWinSceneAction = SKAction.fadeOutWithDuration(0.3)
        gameObjects.runAction(hideWinSceneAction)
    }

    func hideWinOverlay() {
        timerValue.alpha = 1
        let hideWinOverlayAction = SKAction.fadeOutWithDuration(0.3)
        winOverlay.runAction(hideWinOverlayAction)
        let showWinSceneAction = SKAction.fadeInWithDuration(0.3)
        gameObjects.runAction(showWinSceneAction)
    }

    func isGameWon() -> Bool {
        return winOverlay.alpha == 1
    }

    func buildLoseOverlay() {
        loseOverlay = SKNode()
        loseOverlay.alpha = 0
        start = nil

        let background = SKShapeNode(rectOfSize: CGSize(width: 3000, height: 2000))
        background.fillColor = SKColor.darkGrayColor()
        background.alpha = 0.25
        loseOverlay.addChild(background)

        let loseScreen = SKLabelNode(text: "Mission Failed. Try again!")
        loseScreen.position = CGPoint(x: 500, y: 400)
        loseScreen.fontName = "Hoefler Text"
        loseScreen.fontSize = 75
        loseOverlay.addChild(loseScreen)

        self.addChild(loseOverlay)
    }

    func showLoseOverlay() {
        instructionOverlay.alpha = 0
        timerValue.alpha = 0
        let showLoseOverlayAction = SKAction.fadeInWithDuration(0.3)
        loseOverlay.runAction(showLoseOverlayAction)
        let hideSceneAction = SKAction.fadeOutWithDuration(0.3)
        gameObjects.runAction(hideSceneAction)
        start = nil
    }

    func hideLoseOverlay() {
        timerValue.alpha = 1
        let hideLoseOverlayAction = SKAction.fadeOutWithDuration(0.3)
        loseOverlay.runAction(hideLoseOverlayAction)
        let showSceneAction = SKAction.fadeInWithDuration(0.3)
        gameObjects.runAction(showSceneAction)
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

    override func didMoveToView(view: SKView) {
        self.gameObjects = SKNode()
        self.addChild(gameObjects)
        self.physicsWorld.speed = 0.0
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.name = "BouncingBalls"
        buttons = SKNode()
        buttons.position = CGPoint(x: 900, y: 400)
        buttons.zPosition = 100
        self.addChild(buttons)

        let pinchRecognzier = UIPinchGestureRecognizer(target: self, action: #selector(SnowballScene.handlePinchGesture(_:)))
        self.view?.addGestureRecognizer(pinchRecognzier)

        let toggleSimulation = createSmallButton(named: SnowballScene.runButtonName, text: "Run", atPoint: CGPoint(x: 80, y: 295), withSize: BaseScene.smallButtonSize)
        buttons.addChild(toggleSimulation)

        let resetButton = createSmallButton(named: SnowballScene.resetButtonName, text: "Reset", atPoint: CGPoint(x: 80, y: 220), withSize: BaseScene.smallButtonSize)
        buttons.addChild(resetButton)

        let menuButton = createSmallButton(named: SnowballScene.menuButtonName, text: "Menu", atPoint: CGPoint(x: 80, y: 155), withSize: BaseScene.smallButtonSize)
        buttons.addChild(menuButton)

        timerValue = SKLabelNode(text: "0")
        timerValue.fontColor = SKColor.whiteColor()
        timerValue.position = CGPoint(x: 550, y: 700)
        timerValue.fontSize = 60
        timerValue.zPosition = 100
        self.addChild(timerValue)

        monster = SKSpriteNode(imageNamed: "Monster")
        monster.name = "monster"
        monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size)
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
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            if instructionOverlay.alpha != 0 {
                self.stopSimulation()
                let hideInstructionsAction = SKAction.fadeOutWithDuration(0.3)
                instructionOverlay.runAction(hideInstructionsAction)
                startTimer()
            }
            if isGameLost() {
                hideLoseOverlay()
                self.stopSimulation()
                resetScene()
                return
            }

            let hideWinInstructionsAction = SKAction.fadeOutWithDuration(0.3)
            instructionOverlay.runAction(hideWinInstructionsAction)

            if isGameWon() {
                hideWinOverlay()
                self.stopSimulation()
                resetScene()
                return
            }

            let nodes = self.nodesAtPoint(touch.locationInNode(self))
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
                        self.addChild(rampNode)
                        self.addChild(snowballNode)
                        self.addChild(buttons)
                        self.addChild(monster)
                        rampNode.maxSize = RampNode.easyMaximumSize
                        snowballMenu.removeFromParent()
                        resetScene()
                    } else if node.name == "MediumButton" {
                        stopSimulation()
                        self.addChild(rampNode)
                        self.addChild(snowballNode)
                        self.addChild(buttons)
                        self.addChild(monster)
                        rampNode.maxSize = RampNode.mediumMaximumSize
                        snowballMenu.removeFromParent()
                        resetScene()
                        timeRemaining = 20
                        timerValue.alpha = 1
                    } else if node.name == "HardButton" {
                        self.stopSimulation()
                        self.addChild(rampNode)
                        self.addChild(snowballNode)
                        self.addChild(buttons)
                        self.addChild(monster)
                        rampNode.maxSize = RampNode.hardMaximumSize
                        snowballMenu.removeFromParent()
                        resetScene()
                        timeRemaining = 10
                        timerValue.alpha = 1
                    } else if node.name == "exitButton" {
                        self.addChild(rampNode)
                        self.addChild(snowballNode)
                        self.addChild(buttons)
                        self.addChild(monster)
                        snowballMenu.removeFromParent()
                        timerValue.alpha = 1
                    } else if node.name == "backToMenuButton" {
                        gameViewController.startMenu()
                    }
                }
            }
        }
    }

    func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        let touch1 = recognizer.locationOfTouch(0, inView: self.view!)
        let touch2 = recognizer.locationOfTouch(1, inView: self.view!)

        if recognizer.state == UIGestureRecognizerState.Began {
            if let ramp = selectedNode as? RampNode {
                ramp.pinchBegan(touch1, touch2: touch2)
            }
            if let snowball = selectedNode as? SnowballNode {
                snowball.pinchBegan(recognizer.scale)
            }
        } else if recognizer.state == UIGestureRecognizerState.Changed {
            if let ramp = selectedNode as? RampNode {
                ramp.pinchChanged(touch1, touch2: touch2)
            }
            if let snowball = selectedNode as? SnowballNode {
                snowball.pinchChanged(recognizer.scale)
            }
        } else if recognizer.state == UIGestureRecognizerState.Ended {
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

    override func update(currentTime: NSTimeInterval) {
        if let monster = monster {
            let π = CGFloat(M_PI) // tailor:disable
            let degrees = abs((monster.zRotation * 180 / π) % 360)

            if degrees > 85 && 280 > degrees {
                let degrees = previousDegrees
                if degrees == previousDegrees {
                    showWinOverlay()
                    stopSimulation()
                } else if previousDegrees == degrees {
                    unselectAll()
                }
                print(degrees)
            }
            if let start = start {
                let interval = NSDate().timeIntervalSinceDate(start)
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
