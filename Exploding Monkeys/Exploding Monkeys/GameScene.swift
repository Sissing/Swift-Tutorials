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

class GameScene: SKScene, SKPhysicsContactDelegate {

	var buildings = [BuildingNode]()
	weak var viewController: GameViewController!
	var player1: SKSpriteNode!
	var player2: SKSpriteNode!
	var banana: SKSpriteNode!
	var currentPlayer = 1

	override func didMove(to view: SKView) {
		self.physicsWorld.contactDelegate = self
		self.backgroundColor = UIColor(hue: 0.669, saturation: 0.99, brightness: 0.67, alpha: 1)

		self.createBuildings()
		self.createPlayers()
	}

	func didBegin(_ contact: SKPhysicsContact) {
		var firstBody: SKPhysicsBody
		var secondBody: SKPhysicsBody

		if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
			firstBody = contact.bodyA
			secondBody = contact.bodyB
		} else {
			firstBody = contact.bodyB
			secondBody = contact.bodyA
		}

		if let firstNode = firstBody.node, let secondNode = secondBody.node {
			if firstNode.name == "banana" && secondNode.name == "building" {
				self.bananaHit(building: secondNode as! BuildingNode, atPoint: contact.contactPoint)
			}

			if firstNode.name == "banana" && secondNode.name == "player1" {
				self.destroy(player: self.player1)
			}

			if firstNode.name == "banana" && secondNode.name == "player2" {
				self.destroy(player: self.player2)
			}
		}
	}

	override func update(_ currentTime: TimeInterval) {
		if self.banana != nil, self.banana.position.y < -1000 {
			self.banana.removeFromParent()
			self.banana = nil

			self.changePlayer()
		}
	}

	private func destroy(player: SKSpriteNode) {
		let explosion = SKEmitterNode(fileNamed: "hitPlayer")!
		explosion.position = player.position
		self.addChild(explosion)

		player.removeFromParent()
		self.banana?.removeFromParent()

		DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
			guard let this = self else {
				return
			}
			let newGame = GameScene(size: this.size)
			newGame.viewController = this.viewController
			this.viewController.currentGame = newGame

			this.changePlayer()
			newGame.currentPlayer = this.currentPlayer
			let transition = SKTransition.doorway(withDuration: 1.5)
			this.view?.presentScene(newGame, transition: transition)
		}
	}

	private func changePlayer() {
		if self.currentPlayer == 1 {
			self.currentPlayer = 2
		} else {
			self.currentPlayer = 1
		}

		self.viewController.activatePlayer(number: self.currentPlayer)
	}

	private func bananaHit(building: BuildingNode, atPoint contactPoint: CGPoint) {
		let buildingLocation = convert(contactPoint, to: building)
		building.hitAt(point: buildingLocation)

		let explosion = SKEmitterNode(fileNamed: "hitBuilding")!
		explosion.position = contactPoint
		self.addChild(explosion)

		self.banana.name = ""
		self.banana.removeFromParent()
		self.banana = nil

		self.changePlayer()
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
		let speed = Double(velocity) / 10.0
		let radians = self.degreesToRadians(angle)

		if self.banana != nil {
			self.banana.removeFromParent()
			self.banana = nil
		}

		self.banana = SKSpriteNode(imageNamed: "banana")
		self.banana.name = "banana"
		self.banana.physicsBody = SKPhysicsBody(circleOfRadius: self.banana.size.width / 2)
		self.banana.physicsBody?.categoryBitMask = CollisionType.banana.rawValue
		self.banana.physicsBody?.collisionBitMask = CollisionType.building.rawValue | CollisionType.player.rawValue
		self.banana.physicsBody?.contactTestBitMask = CollisionType.building.rawValue | CollisionType.player.rawValue
		self.banana.physicsBody?.usesPreciseCollisionDetection = true
		self.addChild(self.banana)

		if self.currentPlayer == 1 {
			self.createSequence(for: self.player1, isPlayer1: true, speed: speed, radians: radians)
		} else {
			self.createSequence(for: self.player2, isPlayer1: false, speed: speed, radians: radians)
		}

	}

	private func createSequence(for player: SKSpriteNode, isPlayer1: Bool, speed: Double, radians: Double) {
		self.banana.position = CGPoint(x: isPlayer1 ? player.position.x - 30 : player.position.x + 30, y: player.position.y + 40)
		self.banana.physicsBody?.angularVelocity = isPlayer1 ? -20 : 20
		let raiseArm = SKAction.setTexture(SKTexture(imageNamed: isPlayer1 ? "player1Throw" : "player2Throw"))
		let lowerArm = SKAction.setTexture(SKTexture(imageNamed: "player"))
		let pause = SKAction.wait(forDuration: 0.15)
		let sequence = SKAction.sequence([raiseArm, pause, lowerArm])
		player.run(sequence)
		let impulse = CGVector(dx: cos(radians) * (isPlayer1 ? speed : -speed), dy: sin(radians) * speed)
		self.banana.physicsBody?.applyImpulse(impulse)
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

	private func degreesToRadians(_ degrees: Int) -> Double {
		return Double(degrees) * Double.pi / 180.0
	}
}
