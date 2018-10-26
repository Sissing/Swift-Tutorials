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
	@IBOutlet private var averageWaterDrunk: UILabel!
	@IBOutlet private var maxLabel: UILabel!
	@IBOutlet private var stackView: UIStackView!

	private var isGraphViewShowing = false

	override func viewDidLoad() {
		super.viewDidLoad()

		self.counterLabel.text = String(self.counterView.counter)

		self.setupGraphDisplay()
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
							  to: self.counterView,
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

	private func setupGraphDisplay() {
		let maxDayIndex = self.stackView.arrangedSubviews.count - 1

		self.graphView.graphPoints[self.graphView.graphPoints.count - 1] = self.counterView.counter
		self.graphView.setNeedsDisplay()
		self.maxLabel.text = "\(self.graphView.graphPoints.max()!)"

		let average = self.graphView.graphPoints.reduce(0, +) / self.graphView.graphPoints.count
		self.averageWaterDrunk.text = "\(average)"

		let today = Date()
		let calendar = Calendar.current

		let formatter = DateFormatter()
		formatter.setLocalizedDateFormatFromTemplate("EEEEE")

		for i in 0...maxDayIndex {
			if let date = calendar.date(byAdding: .day, value: -i, to: today), let label = self.stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
				label.text = formatter.string(from: date)
			}
		}
	}

}
