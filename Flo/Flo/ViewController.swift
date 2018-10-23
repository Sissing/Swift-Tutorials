//
//  ViewController.swift
//  Flo
//
//  Created by Ruben Sissing on 23/10/2018.
//  Copyright © 2018 Sissing.nl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet private var counterView: CounterView!
	@IBOutlet private var counterLabel: UILabel!

	@IBAction func pushButtonPressed(_ button: PushButton) {
		if button.isAddButton {
			self.counterView.counter += 1
		} else if self.counterView.counter > 0 {
			self.counterView.counter -= 1
		}
		self.counterLabel.text = String(self.counterView.counter)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.counterLabel.text = String(self.counterView.counter)
	}

}

