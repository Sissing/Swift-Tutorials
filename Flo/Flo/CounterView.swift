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

		self.drawCounterViewMarkers(rect: rect, arcLengthPerGlass: arcLengthPerGlass, startAngle: startAngle)
	}

	private func drawCounterViewMarkers(rect: CGRect, arcLengthPerGlass: CGFloat, startAngle: CGFloat) {
		let context = UIGraphicsGetCurrentContext()!
		context.saveGState()
		self.outlineColor.setFill()

		let markerWidth: CGFloat = 5.0
		let markerSize: CGFloat = 10.0

		let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth / 2, y: 0, width: markerWidth, height: markerSize))

		context.translateBy(x: rect.width / 2, y: rect.height / 2)

		for i in 1...Constants.numberOfGlasses {
			context.saveGState()

			let angle = arcLengthPerGlass * CGFloat(i) + startAngle - .pi / 2

			context.rotate(by: angle)
			context.translateBy(x: 0, y: rect.height / 2 - markerSize)

			markerPath.fill()
			context.restoreGState()
		}

		context.restoreGState()
	}

}
