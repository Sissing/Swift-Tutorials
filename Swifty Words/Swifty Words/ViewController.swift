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
	private var score = 0
	private var level = 1

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

	@IBAction private func submitTapped(_ sender: Any) {
	}

	@IBAction private func clearTapped(_ sender: Any) {
	}

	@IBAction private func letterTapped(_ sender: Any) {
	}

}

