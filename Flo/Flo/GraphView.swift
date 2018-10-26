//
//  GraphView.swift
//  Flo
//
//  Created by Ruben Sissing on 25/10/2018.
//  Copyright © 2018 Sissing.nl. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {

	@IBInspectable var startColor: UIColor = .red
	@IBInspectable var endColor: UIColor = .green

	private struct Constants {
		static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
		static let margin: CGFloat = 20.0
		static let topBorder: CGFloat = 60
		static let bottomBorder: CGFloat = 50
		static let colorAlpha: CGFloat = 0.3
		static let circleDiameter: CGFloat = 5.0
	}

	override func draw(_ rect: CGRect) {
		let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: Constants.cornerRadiusSize)
		path.addClip()
		let context = UIGraphicsGetCurrentContext()!
		let colors = [self.startColor.cgColor, self.endColor.cgColor] as CFArray

		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let colorLocations: [CGFloat] = [0.0, 1.0]

		let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: colorLocations)!

		let startPoint = CGPoint.zero
		let endPoint = CGPoint(x: 0, y: self.bounds.height)
		context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
	}

}
