//
//  CounterView.swift
//  Flo
//
//  Created by Ruben Sissing on 23/10/2018.
//  Copyright © 2018 Sissing.nl. All rights reserved.
//

import UIKit

@IBDesignable class CounterView: UIView {

	@IBInspectable var counter: Int = 5 {
		didSet {
			if counter <= Constants.numberOfGlasses {
				self.setNeedsDisplay()
			}
		}
	}
	@IBInspectable var outlineColor: UIColor = .blue
	@IBInspectable var counterColor: UIColor = .orange

	private struct Constants {
		static let numberOfGlasses = 8
		static let lineWidth: CGFloat = 5.0
		static let arcWidth: CGFloat = 76

		static var halfOfLineWidth: CGFloat {
			return self.lineWidth / 2
		}
	}

	override func draw(_ rect: CGRect) {
		let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
		let radius: CGFloat = max(self.bounds.width, self.bounds.height)
		let startAngle: CGFloat = 3 * .pi / 4
		let endAngle: CGFloat = .pi / 4

		let path = UIBezierPath(arcCenter: center,
								radius: radius / 2 - Constants.arcWidth / 2,
								startAngle: startAngle,
								endAngle: endAngle,
								clockwise: true)

		path.lineWidth = Constants.arcWidth
		self.counterColor.setStroke()
		path.stroke()

		let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
		let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOfGlasses)
		let outlineEndAngle = arcLengthPerGlass * CGFloat(self.counter) + startAngle

		let outlinePath = UIBezierPath(arcCenter: center,
									   radius: self.bounds.width / 2 - Constants.halfOfLineWidth,
									   startAngle: startAngle,
									   endAngle: outlineEndAngle,
									   clockwise: true)

		outlinePath.addArc(withCenter: center,
						   radius: self.bounds.width / 2 - Constants.arcWidth + Constants.halfOfLineWidth,
						   startAngle: outlineEndAngle,
						   endAngle: startAngle,
						   clockwise: false)
		outlinePath.close()

		self.outlineColor.setStroke()
		outlinePath.lineWidth = Constants.lineWidth
		outlinePath.stroke()
	}

}
