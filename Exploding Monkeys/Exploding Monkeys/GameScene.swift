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
	weak var viewcontroller: GameViewController!
	var player1: SKSpriteNode!
	var player2: SKSpriteNode!
	var banana: SKSpriteNode!
	var currentPlayer = 1

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

	func launch(angle: Int, velocity: Int) {
		
	}

	func createPlayers() {
		self.player1 = SKSpriteNode(imageNamed: "player")
		self.player1.name = "player1"
		self.player1.physicsBody = SKPhysicsBody(circleOfRadius: self.player1.size.width / 2)
		self.player1.physicsBody?.categoryBitMask = CollisionType.player.rawValue
		self.player1.physicsBody?.collisionBitMask = CollisionType.banana.rawValue
		self.player1.physicsBody?.contactTestBitMask = CollisionType.banana.rawValue
		self.player1.physicsBody?.isDynamic = false

		let player1Building = buildings[1]
		self.player1.position = CGPoint(x: player1Building.position.x, y: player1Building.position.y + ((player1Building.size.height + self.player1.size.height) / 2))
		self.addChild(player1)

		self.player2 = SKSpriteNode(imageNamed: "player")
		self.player2.name = "player2"
		self.player2.physicsBody = SKPhysicsBody(circleOfRadius: self.player2.size.width / 2)
		self.player2.physicsBody?.categoryBitMask = CollisionType.player.rawValue
		self.player2.physicsBody?.collisionBitMask = CollisionType.banana.rawValue
		self.player2.physicsBody?.contactTestBitMask = CollisionType.banana.rawValue
		self.player2.physicsBody?.isDynamic = false

		let player2Building = buildings[buildings.count - 2]
		self.player2.position = CGPoint(x: player2Building.position.x, y: player2Building.position.y + ((player2Building.size.height + self.player2.size.height) / 2))

		self.addChild(self.player2)
	}
}
