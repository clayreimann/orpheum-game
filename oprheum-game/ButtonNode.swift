//
//  ButtonNode.swift
//  orpheum-game
//
//  Created by Christopher Reimann on 11/30/16.
//
//

import SpriteKit

class ButtonNode: SKNode {

    static let defaultCornerRadius: CGFloat = 4.0

    static let defaultFontSize: CGFloat = 20
    static let defaultFontName = UIFont.boldSystemFontOfSize(1).fontName

    static let defaultButtonFillColor = SKColor(red: 0.621, green: 0.864, blue: 1.000, alpha: 1.000)

    /*
     *  ButtonNode's public API
     */
    var text: String
    var size: CGSize
    var cornerRadius = ButtonNode.defaultCornerRadius {
        didSet(old) {
            button.path = buttonPath
            positionLabel()
        }
    }
    var fillColor = ButtonNode.defaultButtonFillColor {
        didSet(old) {
            button.fillColor = fillColor
        }
    }
    var fontColor = SKColor.darkGrayColor() {
        didSet(old) {
            label.fontColor = fontColor
        }
    }
    var fontSize = ButtonNode.defaultFontSize {
        didSet(old) {
            label.fontSize = fontSize
            positionLabel()
        }
    }
    var fontName = ButtonNode.defaultFontName {
        didSet(old) {
            label.fontName = fontName
        }
    }

    /*
     *  Private implementation details
     */
    private var buttonPath: CGPath {
        let rect = CGRect(origin: CGPoint(x: -0.5 * size.width, y: -0.5 * size.height), size: size)
        return CGPathCreateWithRoundedRect(rect, cornerRadius, cornerRadius, nil)
    }
    private var button: SKShapeNode!
    private var label: SKLabelNode!

    init(name: String, text: String, size: CGSize) {
        self.text = text
        self.size = size

        super.init()
        self.name = name

        buildButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildButton() {
        button = SKShapeNode(path: buttonPath)
        button.fillColor = fillColor
        self.addChild(button)

        label = SKLabelNode(text: text)
        label.fontSize = fontSize
        label.fontName = fontName
        label.fontColor = fontColor
        label.userInteractionEnabled = false
        button.addChild(label)

        positionLabel()
    }

    private func positionLabel() {
        label.position = CGPoint(x: 0, y: -1 * fontSize / 2)
    }
}
