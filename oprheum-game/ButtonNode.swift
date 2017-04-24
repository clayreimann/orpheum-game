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
    static let defaultFontName = UIFont.boldSystemFont(ofSize: 1).fontName

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
    var fontColor = SKColor.darkGray {
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
    fileprivate var buttonPath: CGPath {
        let rect = CGRect(origin: CGPoint(x: -0.5 * size.width, y: -0.5 * size.height), size: size)
        return CGPath(roundedRect: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
    }
    fileprivate var button: SKShapeNode!
    fileprivate var label: SKLabelNode!

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

    fileprivate func buildButton() {
        button = SKShapeNode(path: buttonPath)
        button.fillColor = fillColor
        self.addChild(button)

        label = SKLabelNode(text: text)
        label.fontSize = fontSize
        label.fontName = fontName
        label.fontColor = fontColor
        label.isUserInteractionEnabled = false
        button.addChild(label)

        positionLabel()
    }

    fileprivate func positionLabel() {
        label.position = CGPoint(x: 0, y: -1 * fontSize / 2)
    }
}
