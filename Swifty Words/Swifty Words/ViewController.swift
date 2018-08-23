//
//  ViewController.swift
//  Swifty Words
//
//  Created by Ruben Sissing on 23/08/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit

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
		// Do any additional setup after loading the view, typically from a nib.
	}

	@IBAction private func submitTapped(_ sender: Any) {
	}

	@IBAction private func clearTapped(_ sender: Any) {
	}

	@IBAction private func letterTapped(_ sender: Any) {
	}

}

