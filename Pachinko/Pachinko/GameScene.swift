//
//  GameScene.swift
//  Pachinko
//
//  Created by Ruben Sissing on 04/09/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	override func didMove(to view: SKView) {
		let background = SKSpriteNode(imageNamed: "background.jpg")
		background.position = CGPoint(x: 512.0, y: 384.0)
		background.blendMode = .replace
		background.zPosition = -1
		self.addChild(background)
		self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

		self.makeBouncer(at: CGPoint(x: 0.0, y: 0.0))
		self.makeBouncer(at: CGPoint(x: 256.0, y: 0.0))
		self.makeBouncer(at: CGPoint(x: 512.0, y: 0.0))
		self.makeBouncer(at: CGPoint(x: 768.0, y: 0.0))
		self.makeBouncer(at: CGPoint(x: 1024.0, y: 0.0))
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			let ball = SKSpriteNode(imageNamed: "ballRed")
			ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
			ball.physicsBody?.restitution = 0.4
			ball.position = location
			addChild(ball)
		}
	}

	private func makeBouncer(at position: CGPoint) {
		let bouncer = SKSpriteNode(imageNamed: "bouncer")
		bouncer.position = position
		bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
		bouncer.physicsBody?.isDynamic = false
		addChild(bouncer)
	}
}
