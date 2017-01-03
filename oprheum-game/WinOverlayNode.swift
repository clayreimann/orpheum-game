//
//  WinOverlayNode.swift
//  orpheum-game
//
//  Created by Anna Troutt on 12/30/16.
//
//

import SpriteKit

class WinOverlayNode: SKNode {
    private var winOverlay: SKNode!
    
    var timerValue: SKLabelNode!
    var start: NSDate?
    var timeRemaining = 30.0

    var gameObjects: SKNode!



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


}

