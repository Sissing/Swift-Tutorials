//
//  GameScene.swift
//  Pachinko
//
//  Created by Ruben Sissing on 04/09/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

	private var scoreLabel: SKLabelNode!
	private var score = 0 {
		didSet {
			self.scoreLabel.text = "Score: \(score)"
		}
	}

	override func didMove(to view: SKView) {
		let background = SKSpriteNode(imageNamed: "background.jpg")
		background.position = CGPoint(x: 512.0, y: 384.0)
		background.blendMode = .replace
		background.zPosition = -1
		self.addChild(background)
		self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
		self.physicsWorld.contactDelegate = self

		self.makeSlot(at: CGPoint(x: 128.0, y: 0.0), isGood: true)
		self.makeSlot(at: CGPoint(x: 384.0, y: 0.0), isGood: false)
		self.makeSlot(at: CGPoint(x: 640.0, y: 0.0), isGood: true)
		self.makeSlot(at: CGPoint(x: 896.0, y: 0.0), isGood: false)

		self.makeBouncer(at: CGPoint(x: 0.0, y: 0.0))
		self.makeBouncer(at: CGPoint(x: 256.0, y: 0.0))
		self.makeBouncer(at: CGPoint(x: 512.0, y: 0.0))
		self.makeBouncer(at: CGPoint(x: 768.0, y: 0.0))
		self.makeBouncer(at: CGPoint(x: 1024.0, y: 0.0))

		self.scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		self.scoreLabel.text = "Score: 0"
		self.scoreLabel.horizontalAlignmentMode = .right
		self.scoreLabel.position = CGPoint(x: 980.0, y: 700.0)
		self.addChild(self.scoreLabel)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			let ball = SKSpriteNode(imageNamed: "ballRed")
			ball.name = "ball"
			ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
			ball.physicsBody?.contactTestBitMask = ball.physicsBody!.collisionBitMask
			ball.physicsBody?.restitution = 0.4
			ball.position = location
			self.addChild(ball)
		}
	}

	private func makeBouncer(at position: CGPoint) {
		let bouncer = SKSpriteNode(imageNamed: "bouncer")
		bouncer.position = position
		bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
		bouncer.physicsBody?.isDynamic = false
		self.addChild(bouncer)
	}

	private func makeSlot(at position: CGPoint, isGood: Bool) {
		let slotBase = SKSpriteNode(imageNamed: isGood ? "slotBaseGood" : "slotBaseBad")
		let slotGlow = SKSpriteNode(imageNamed: isGood ? "slotGlowGood" : "slotGlowBad")
		slotBase.name = isGood ? "good" : "bad"
		slotBase.position = position
		slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
		slotBase.physicsBody?.isDynamic = false
		slotGlow.position = position
		self.addChild(slotBase)
		self.addChild(slotGlow)

		let spin = SKAction.rotate(byAngle: .pi, duration: 10.0)
		let spinForever = SKAction.repeatForever(spin)
		slotGlow.run(spinForever)
	}
}

extension GameScene: SKPhysicsContactDelegate {
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else {
			return
		}
		if nodeA.name == "ball" {
			self.collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
		} else if nodeB.name == "ball" {
			self.collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
		}
	}

	private func collisionBetween(ball: SKNode, object: SKNode) {
		switch object.name {
		case .some("good"):
			self.destroy(ball: ball)
			self.score += 1
		case .some("bad"):
			self.destroy(ball: ball)
			self.score -= 1
		default:
			break
		}
	}

	private func destroy(ball: SKNode) {
		ball.removeFromParent()
	}
}
