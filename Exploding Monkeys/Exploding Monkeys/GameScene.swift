//
//  GameScene.swift
//  Exploding Monkeys
//
//  Created by Ruben Sissing on 13/12/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import SpriteKit
import GameplayKit

enum CollisionType: UInt32 {
	case banana = 1
	case building = 2
	case player = 4
}

class GameScene: SKScene {

	var buildings = [BuildingNode]()

	override func didMove(to view: SKView) {
		self.backgroundColor = UIColor(hue: 0.669, saturation: 0.99, brightness: 0.67, alpha: 1)

		self.createBuildings()
	}

	private func createBuildings() {
		var currentX: CGFloat = -15

		while currentX < 1024 {
			let size = CGSize(width: Int.random(in: 2...4) * 40, height: Int.random(in: 300...600))
			currentX += size.width + 2
			let building = BuildingNode(color: .red, size: size)
			building.position = CGPoint(x: currentX - (size.width / 2), y: size.height / 2)
			building.setup()
			self.addChild(building)
			buildings.append(building)
		}
	}

}
