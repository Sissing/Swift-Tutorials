//
//  ViewController.swift
//  Swifty Words
//
//  Created by Ruben Sissing on 23/08/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit
import GameplayKit

final class ViewController: UIViewController {

	@IBOutlet private var cluesLabel: UILabel!
	@IBOutlet private var answersLabel: UILabel!
	@IBOutlet private var currentAnswerInput: UITextField!
	@IBOutlet private var scoreLabel: UILabel!
	@IBOutlet private var letterButtons: [UIButton]!

	private var activatedButtons = [UIButton]()
	private var solutions = [String]()
	private var level = 1
	private var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.loadLevel()
	}

	private func loadLevel() {
		var clueString = ""
		var solutionString = ""
		var letterBits = [String]()

		if let levelFilePath = Bundle.main.path(forResource: "level\(self.level)", ofType: "txt"), let levelContents = try? String(contentsOfFile: levelFilePath) {
			var lines = levelContents.components(separatedBy: "\n")
			lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]

			for (index, line) in lines.enumerated() {
				let parts = line.components(separatedBy: ": ")
				let answer = parts[0]
				let clue = parts[1]

				clueString += "\(index + 1). \(clue)\n"
				let solutionWord = answer.replacingOccurrences(of: "|", with: "")
				solutionString += "\(solutionWord.count) letters\n"
				self.solutions.append(solutionWord)

				let bits = answer.components(separatedBy: "|")
				letterBits += bits
			}
		}

		self.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
		self.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
		letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]

		if letterBits.count == self.letterButtons.count {
			for i in 0 ..< letterBits.count {
				self.letterButtons[i].setTitle(letterBits[i], for: .normal)
			}
		}
	}

	private func levelUp(action: UIAlertAction) {
		self.level += 1
		self.solutions.removeAll(keepingCapacity: true)

		self.loadLevel()

		for button in self.letterButtons {
			button.isEnabled = true
		}
	}

	@IBAction private func submitTapped(_ sender: Any) {
		if let solutionPosition = self.solutions.index(of: self.currentAnswerInput.text!) {
			self.activatedButtons.removeAll()

			var splitAnswers = self.answersLabel.text!.components(separatedBy: "\n")
			splitAnswers[solutionPosition] = self.currentAnswerInput.text!
			self.answersLabel.text = splitAnswers.joined(separator: "\n")

			self.currentAnswerInput.text = ""
			self.score += 1

			if self.score % 7 == 0 {
				let alertController = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
				alertController.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
				present(alertController, animated: true)
			}
		}
	}

	@IBAction private func clearTapped(_ sender: Any) {
		self.currentAnswerInput.text = ""

		for button in self.activatedButtons {
			button.isEnabled = true
		}

		self.activatedButtons.removeAll()
	}

	@IBAction private func letterTapped(_ sender: UIButton) {
		self.currentAnswerInput.text = self.currentAnswerInput.text! + sender.titleLabel!.text!
		self.activatedButtons.append(sender)
		sender.isEnabled = false
	}

}

