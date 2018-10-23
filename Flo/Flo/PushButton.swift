//
//  PushButton.swift
//  Flo
//
//  Created by Ruben Sissing on 23/10/2018.
//  Copyright © 2018 Sissing.nl. All rights reserved.
//

import UIKit

@IBDesignable class PushButton: UIButton {

	@IBInspectable var fillColor: UIColor = .green
	@IBInspectable var isAddButton: Bool = true

	private struct Constants {
		static let plusLineWidth: CGFloat = 3.0
		static let plusButtonScale: CGFloat = 0.6
		static let halfPointShift: CGFloat = 0.5
	}

	private var halfWidth: CGFloat {
		return self.bounds.width / 2
	}

	private var halfHeight: CGFloat {
		return self.bounds.height / 2
	}

	override func draw(_ rect: CGRect) {
		let path = UIBezierPath(ovalIn: rect)
		self.fillColor.setFill()
		path.fill()

		let plusWidth: CGFloat = min(self.bounds.width, self.bounds.height) * Constants.plusButtonScale
		let halfPlusWidth = plusWidth / 2

		let plusPath = UIBezierPath()

		plusPath.lineWidth = Constants.plusLineWidth

		// horizontal line
		plusPath.move(to: CGPoint(
			x: self.halfWidth - halfPlusWidth + Constants.halfPointShift,
			y: self.halfHeight + Constants.halfPointShift
		))

		plusPath.addLine(to: CGPoint(
			x: self.halfWidth + halfPlusWidth + Constants.halfPointShift,
			y: self.halfHeight + Constants.halfPointShift
		))

		if self.isAddButton {
		// vertical line
			plusPath.move(to: CGPoint(
				x: self.halfWidth + Constants.halfPointShift,
				y: self.halfHeight - halfPlusWidth + Constants.halfPointShift
			))

			plusPath.addLine(to: CGPoint(
				x: self.halfWidth + Constants.halfPointShift,
				y: self.halfHeight + halfPlusWidth + Constants.halfPointShift
			))
		}

		UIColor.white.setStroke()

		plusPath.stroke()
	}

}
