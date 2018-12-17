//
//  BuildingNode.swift
//  Exploding Monkeys
//
//  Created by Ruben Sissing on 13/12/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit
import SpriteKit

class BuildingNode: SKSpriteNode {

	private var currentImage: UIImage!

	func setup() {
		self.name = "building"
		self.currentImage = self.drawBuilding(size: self.size)
		self.texture = SKTexture(image: currentImage)

		self.configurePhysics()
	}

	private func configurePhysics() {
		self.physicsBody = SKPhysicsBody(texture: texture!, size: size)
		self.physicsBody?.isDynamic = false
		self.physicsBody?.categoryBitMask = CollisionType.building.rawValue
		self.physicsBody?.contactTestBitMask = CollisionType.banana.rawValue
	}

	private func drawBuilding(size: CGSize) -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { context in
			let rectangle = CGRect(x: 0, y: 0, width: size.width, height: size.height)
			var color: UIColor

			switch Int.random(in: 0...2) {
			case 0:
				color = UIColor(hue: 0.999, saturation: 0.99, brightness: 0.67, alpha: 1)
			case 1:
				color = UIColor(hue: 0.502, saturation: 0.98, brightness: 0.67, alpha: 1)
			default:
				color = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 1)
			}

			context.cgContext.setFillColor(color.cgColor)
			context.cgContext.addRect(rectangle)
			context.cgContext.drawPath(using: .fill)

			let lightOnColor = UIColor(hue: 0.190, saturation: 0.67, brightness: 0.99, alpha: 1)
			let lightOffColor = UIColor(hue: 0, saturation: 0, brightness: 0.34, alpha: 1)

			for row in stride(from: 10, to: Int(size.height - 10), by: 40) {
				for col in stride(from: 10, to: Int(size.width - 10), by: 40) {
					context.cgContext.setFillColor(Bool.random() ? lightOnColor.cgColor : lightOffColor.cgColor)
					context.cgContext.fill(CGRect(x: col, y: row, width: 15, height: 20))
				}
			}
		}
	}

	func hitAt(point: CGPoint) {
		let convertedPoint = CGPoint(x: point.x + size.width / 2.0, y: abs(point.y - (size.height / 2.0)))
		let renderer = UIGraphicsImageRenderer(size: size)
		let image = renderer.image { context in
			self.currentImage.draw(at: .zero)
			context.cgContext.addEllipse(in: CGRect(x: convertedPoint.x - 32, y: convertedPoint.y - 32, width: 64, height: 64))
			context.cgContext.setBlendMode(.clear)
			context.cgContext.drawPath(using: .fill)
		}
		texture = SKTexture(image: image)
		self.currentImage = image
		self.configurePhysics()
	}

}
