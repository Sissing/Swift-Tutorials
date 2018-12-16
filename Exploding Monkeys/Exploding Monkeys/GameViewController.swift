//
//  GameViewController.swift
//  Exploding Monkeys
//
//  Created by Ruben Sissing on 13/12/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

	@IBOutlet private var angleSlider: UISlider!
	@IBOutlet private var angleLabel: UILabel!
	@IBOutlet private var velocitySlider: UISlider!
	@IBOutlet private var velocityLabel: UILabel!
	@IBOutlet private var launchButton: UIButton!
	@IBOutlet private var playerNumber: UILabel!

	var currentGame: GameScene!

	override func viewDidLoad() {
		super.viewDidLoad()

		if let view = self.view as! SKView? {
			// Load the SKScene from 'GameScene.sks'
			if let scene = SKScene(fileNamed: "GameScene") {
				// Set the scale mode to scale to fit the window
				scene.scaleMode = .aspectFill

				// Present the scene
				view.presentScene(scene)
				self.currentGame = scene as? GameScene
				self.currentGame.viewcontroller = self
			}

			view.ignoresSiblingOrder = true

			view.showsFPS = true
			view.showsNodeCount = true
		}
	}

	@IBAction private func angleChanged(_ sender: Any) {
	}

	@IBAction private func velocityChanged(_ sender: Any) {
	}

	@IBAction private func launch(_ sender: Any) {
	}

	override var shouldAutorotate: Bool {
		return true
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		if UIDevice.current.userInterfaceIdiom == .phone {
			return .allButUpsideDown
		} else {
			return .all
		}
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}
}
