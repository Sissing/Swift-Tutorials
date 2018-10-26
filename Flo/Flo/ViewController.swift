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
	@IBOutlet private var containerView: UIView!
	@IBOutlet private var graphView: GraphView!

	private var isGraphViewShowing = false

	override func viewDidLoad() {
		super.viewDidLoad()

		self.counterLabel.text = String(self.counterView.counter)
	}

	@IBAction private func pushButtonPressed(_ button: PushButton) {
		if button.isAddButton {
			self.counterView.counter += 1
		} else if self.counterView.counter > 0 {
			self.counterView.counter -= 1
		}
		self.counterLabel.text = String(self.counterView.counter)

		if self.isGraphViewShowing {
			self.counterViewTap(nil)
		}
	}
	
	@IBAction private func counterViewTap(_ gesture: UITapGestureRecognizer?) {
		if self.isGraphViewShowing {
			UIView.transition(from: self.graphView,
							  to: self.containerView,
							  duration: 1.0,
							  options: [.transitionFlipFromLeft, .showHideTransitionViews],
							  completion: nil)
		} else {
			UIView.transition(from: self.counterView,
							  to: self.graphView,
							  duration: 1.0,
							  options: [.transitionFlipFromRight, .showHideTransitionViews],
							  completion: nil)
		}
		self.isGraphViewShowing = !self.isGraphViewShowing
	}

}
