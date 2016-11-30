//
//  GameViewController.swift
//
//  Copyright © 2016 Yichen Yao, Elizabeth Singer, Hadley Shapland. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        startMenu()
    }

    func startMenu() {
        if let menuScene = MenuScene(fileNamed: "MenuScene"),
            let skView = self.view as? SKView {
            configureAndPresent(skView, scene: menuScene)
        }
    }

    func startSnowballGame() {
        if let snowballGameScene = SnowballScene(fileNamed: "SnowballScene"),
            let skView = self.view as? SKView {
            configureAndPresent(skView, scene: snowballGameScene)
        }
    }

    func startLeverGame() {
        if let leverGameScene = LeverScene(fileNamed: "LeverScene"),
            let skView = self.view as? SKView {
            configureAndPresent(skView, scene: leverGameScene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func configureAndPresent(view: SKView, scene: BaseScene) {
        view.showsFPS = true
        view.showsNodeCount = true

        view.showsPhysics = true // Set to true to see bounding boxes
        view.ignoresSiblingOrder = true // Sprite Kit applies additional optimizations to improve rendering performance

        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        scene.gameViewController = self

        view.presentScene(scene)
    }
}
