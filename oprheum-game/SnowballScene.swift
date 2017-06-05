//
//  GameScene.swift
// make menu difficulty buttons do something, back to main main menu
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.

import SpriteKit

class SnowballScene: BaseScene {
    static let runButtonName = "runButton"
    static let retryButtonName = "retryButton"
    static let resetButtonName = "resetButton"
    static let menuButtonName = "menuButton"
    static let physicsInstructionsName = "physicsInstructionsButton"

    static let easyInitialTime = 30.0
    static let mediumInitialTime = 20.0
    static let hardInitialTime = 10.0

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
    var timeRemaining = SnowballScene.easyInitialTime
    var initialLevelTime = SnowballScene.easyInitialTime

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
        buttons.position = CGPoint(x: 950, y: 400)
        buttons.zPosition = 100
        buildButtons()
        self.addChild(buttons)

        let pinchRecognzier = UIPinchGestureRecognizer(target: self, action: #selector(SnowballScene.handlePinchGesture(_:)))
        self.view?.addGestureRecognizer(pinchRecognzier)

        timerValue = SKLabelNode(text: String(format:"%.1f", initialLevelTime))
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

        self.addChild(loseOverlay)
        self.addChild(winOverlay)

        instructionOverlay = InstructionOverlayNode(scene: self)
        instructionOverlay.text1 = "Use the snowball and ramp to try and\nknock the monster down with the snowball"
        instructionOverlay.text2 = "Tap on the ramp or the snowball to select them then pinch to resize"
        instructionOverlay.text3 = "Tap to continue"
        self.addChild(instructionOverlay)

        resetScene()
    }

    func buildButtons() {
        let toggleSimulation = ButtonNode(name: SnowballScene.runButtonName, text: "Run", size: BaseScene.smallButtonSize)
        toggleSimulation.position = CGPoint(x: 0, y: 330)
        buttons.addChild(toggleSimulation)

        let resetButton = ButtonNode(name: SnowballScene.retryButtonName, text: "Retry", size: BaseScene.smallButtonSize)
        resetButton.position = CGPoint(x: 0, y: 265)
        buttons.addChild(resetButton)

        let timerResetButton = ButtonNode(name: SnowballScene.resetButtonName, text: "Reset", size: BaseScene.smallButtonSize)
        timerResetButton.position = CGPoint(x: 0, y: 200)
        buttons.addChild(timerResetButton)

        let menuButton = ButtonNode(name: SnowballScene.menuButtonName, text: "Menu", size: BaseScene.smallButtonSize)
        menuButton.position = CGPoint(x: 0, y: 135)
        buttons.addChild(menuButton)

        let physicsInstructions = ButtonNode(name: SnowballScene.physicsInstructionsName, text: "?", size: BaseScene.smallButtonSize)
        physicsInstructions.position = CGPoint(x: 0, y: 20)
        buttons.addChild(physicsInstructions)
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

    func runButtonTouched(_ touch: NSValue) -> Bool {
        resetScene()
        startSimulation()
        return true
    }

    func retryButtonTouched(_ touch: NSValue) -> Bool {
        resetScene()
        stopSimulation()
        return true
    }

    func resetButtonTouched(_ touch: NSValue) -> Bool {
        resetScene()
        stopSimulation()
        rampNode.redrawTriangle(RampNode.initialSize, height: RampNode.initialSize)
        snowballNode.setSnowballMass(SnowballNode.initialMass)

        timeRemaining = initialLevelTime
        return true
    }

    func menuButtonTouched(_ touch: NSValue) -> Bool {
        start = nil
        timerValue.alpha = 0
        rampNode.removeFromParent()
        snowballNode.removeFromParent()
        buttons.removeFromParent()
        monster.removeFromParent()
        snowballMenu = SnowballMenu()
        self.addChild(snowballMenu)
        return true
    }

    func easyButtonTouched(_ touch: NSValue) -> Bool {
        adjustForDifficulty(rampSize: RampNode.easyMaximumSize, levelTime: SnowballScene.easyInitialTime)
        return true
    }

    func mediumButtonTouched(_ touch: NSValue) -> Bool {
        adjustForDifficulty(rampSize: RampNode.mediumMaximumSize, levelTime: SnowballScene.mediumInitialTime)
        return true
    }

    func hardButtonTouched(_ touch: NSValue) -> Bool {
        adjustForDifficulty(rampSize: RampNode.hardMaximumSize, levelTime: SnowballScene.hardInitialTime)
        return true
    }

    func adjustForDifficulty(rampSize: CGFloat, levelTime: Double) {
        stopSimulation()
        addGameObjectsToScene()
        rampNode.maxSize = rampSize
        timeRemaining = levelTime
        initialLevelTime = levelTime
        snowballMenu.removeFromParent()
        resetScene()
    }

    func exitButtonTouched(_ touch: NSValue) -> Bool {
        addGameObjectsToScene()
        snowballMenu.removeFromParent()
        timerValue.alpha = 1
        return true
    }

    func backToMenuButtonTouched(_ touch: NSValue) -> Bool {
        gameViewController.startMenu()
        return true
    }

    func physicsInstructionsButtonTouched(_ touch: NSValue) -> Bool {
        start = nil
        timerValue.alpha = 0
        rampNode.removeFromParent()
        snowballNode.removeFromParent()
        buttons.removeFromParent()
        monster.removeFromParent()
        physicsInstructions = SnowballGamePhysics()
        self.addChild(physicsInstructions)
        return true
    }

    func exitInstructionsButtonTouched(_ touch: NSValue) -> Bool {
        addGameObjectsToScene()
        physicsInstructions.removeFromParent()
        timerValue.alpha = 1
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if instructionOverlay.alpha != 0 {
            self.stopSimulation()
            let hideInstructionsAction = SKAction.fadeOut(withDuration: 0.3)
            instructionOverlay.run(hideInstructionsAction)
            startTimer()
        }

        if isGameLost() || isGameWon() {
            stopSimulation()

            hideLoseOverlay()
            hideWinOverlay()

            addGameObjectsToScene()
            resetScene()
            snowballNode.redrawSnowball()
            rampNode.redrawTriangle(200, height: 200)
            timeRemaining = initialLevelTime
            return
        }

        let hideWinInstructionsAction = SKAction.fadeOut(withDuration: 0.3)
        instructionOverlay.run(hideWinInstructionsAction)

        for touch in touches {
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
