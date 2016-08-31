//
//  GameScene.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//

import SpriteKit

func limit(val: CGFloat) -> (CGFloat) {
    var result = val
    
    if val > 700 {
        result = 700
    } else if val < 100 {
        result = 100
    }
    
    return result
}

class SnowballScene: SKScene {
    var gameViewController: GameViewController!
    var difficulty: CGFloat = 0.5
    
    var selectedNode: SKNode?

    var buttons: SKNode!

    var gameObjects: SKNode!
    var snowballNode: SnowballNode!
    var rampNode: RampNode!
    var monster: SKSpriteNode!

    var instructionOverlay: SKNode!
    var winOverlay: SKNode!
    var loseOverlay: SKNode!
    
    var previousDegrees: Int = 0
    var start: NSDate?
    var timerValue: SKLabelNode!
    // create sklabel node to hold the current value of the timer
    
    func stopSimulation() {
        self.physicsWorld.speed = 0.0
        start = nil
    }
    
    func startSimulation() {
        self.physicsWorld.speed = 1.0
        start = NSDate()
    }
    
    func buildInstructionOverlay() {
        instructionOverlay = SKNode()
        
        let background = SKShapeNode(rectOfSize: CGSize(width: 3000, height: 2000))
        background.fillColor = SKColor.blackColor()
        background.alpha = 0.25
        instructionOverlay.addChild(background)
        
        let instructions = SKLabelNode(text: "Tap to continue")
        instructions.position = CGPoint(x: 500, y: 50)
        instructions.fontName = "Hoefler Text"
        instructions.fontSize = 25
        instructionOverlay.addChild(instructions)
        
        let instructionsResize = SKLabelNode(text: "Pinch to resize")
        instructionsResize.position = CGPoint(x: 220, y: 700)
        instructionsResize.fontName = "Hoefler Text"
        instructionOverlay.addChild(instructionsResize)
        
        let instructionsPlay = SKLabelNode(text: "Resize the snowball and ramp to try and ")
        instructionsPlay .position = CGPoint(x: 500, y: 370)
        instructionsPlay.fontName = "Hoefler Text"
        instructionOverlay.addChild(instructionsPlay)
        
        
        let instructionsPlay2 = SKLabelNode(text: "knock the monster down with the snowball!")
        instructionsPlay2 .position = CGPoint(x: 500, y: 330)
        instructionsPlay2.fontName = "Hoefler Text"
        instructionOverlay.addChild(instructionsPlay2)
    
        
        self.addChild(instructionOverlay)
    }
    
    func buildWinOverlay() {
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
        let showWinOverlayAction = SKAction.fadeInWithDuration(0.3)
        winOverlay.runAction(showWinOverlayAction)
        let hideWinSceneAction = SKAction.fadeOutWithDuration(0.3)
        gameObjects.runAction(hideWinSceneAction)
    }
    
    func hideWinOverlay() {
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
        let showLoseOverlayAction = SKAction.fadeInWithDuration(0.3)
        loseOverlay.runAction(showLoseOverlayAction)
        let hideSceneAction = SKAction.fadeOutWithDuration(0.3)
        gameObjects.runAction(hideSceneAction)
    }
    
    func hideLoseOverlay() {
        let hideLoseOverlayAction = SKAction.fadeOutWithDuration(0.3)
        loseOverlay.runAction(hideLoseOverlayAction)
        let showSceneAction = SKAction.fadeInWithDuration(0.3)
        gameObjects.runAction(showSceneAction)
    }
    
    func isGameLost() -> Bool {
        return loseOverlay.alpha == 1
    }
    
    func resetScene() {
        self.stopSimulation()
        
        hideWinOverlay()
        hideLoseOverlay()
        
        snowballNode.position = CGPoint(x:30, y:self.frame.height - 30)
        snowballNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        snowballNode.zPosition = 0
        
        monster.position = CGPoint(x:700, y:monster.size.height/2)
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

        let pinchRecognzier = UIPinchGestureRecognizer(target: self, action:
            #selector(SnowballScene.handlePinchGesture(_:)))
        self.view?.addGestureRecognizer(pinchRecognzier)
        
        let toggleSimulation = SKShapeNode(rect: CGRect(x: 50, y: 315, width: 70, height: 50), cornerRadius: 4)
        buttons.addChild(toggleSimulation)
        toggleSimulation.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        toggleSimulation.name = "RunButton"
        
        let toggleSimulationLabel = SKLabelNode(text: "Run")
        toggleSimulationLabel.position = CGPoint(x: 85, y: 335)
        toggleSimulationLabel.fontSize = 20
        toggleSimulationLabel.fontColor = SKColor.darkGrayColor()
        toggleSimulationLabel.userInteractionEnabled = false
        toggleSimulation.addChild(toggleSimulationLabel)
        //run button + label
        
        let resetButton = SKShapeNode(rect: CGRect(x: 50, y: 255, width: 70, height: 50), cornerRadius: 4)
        buttons.addChild(resetButton)
        resetButton.fillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)
        resetButton.name = "ResetButton"
        
        let resetButtonLabel = SKLabelNode(text: "Reset")
        resetButtonLabel.position = CGPoint(x: 85, y: 275)
        resetButtonLabel.fontSize = 20
        resetButtonLabel.fontColor = SKColor.darkGrayColor()
        //resetButtonLabel.fontColor = SKColor.whiteColor()
        resetButtonLabel.userInteractionEnabled = false
        resetButton.addChild(resetButtonLabel)
        //reset button + label
        
        // build the timer label
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
            let hideInstructionsAction = SKAction.fadeOutWithDuration(0.3)
            instructionOverlay.runAction(hideInstructionsAction)
            
            if isGameLost() {
                hideLoseOverlay()
                resetScene()
                return
            }

            let hideWinInstructionsAction = SKAction.fadeOutWithDuration(0.3)
            instructionOverlay.runAction(hideWinInstructionsAction)
            
            if isGameWon() {
                hideWinOverlay()
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
                        resetScene()
                    }
                }
            }
        }
    }

    func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        //let center = recognizer.locationInView(self.view!)
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
    
    func redrawBall(){
        snowballNode.redrawSnowball()
    }
    
    //changes ball mass
    func changeBallMass() {
        snowballNode.setSnowballMass(25)
    }
    
    override func update(currentTime: NSTimeInterval) {
        if let monster = monster {
            let π = CGFloat(M_PI)
            let degrees = (monster.zRotation * 180 / π) % 360
            
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
                let timeout: Double = 30

                if interval > timeout {
                    showLoseOverlay()
                    stopSimulation()
                }
                
                timerValue.text = String(format: "%.1f", (timeout - interval))
                let x = String(format: "%.1f", (timeout - interval))
                print("\(timeout) - \(interval) = \(x)")
                
            }
        }
    }
}
