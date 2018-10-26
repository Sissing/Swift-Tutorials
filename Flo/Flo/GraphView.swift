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

	private var graphPoints = [4, 2, 6, 4, 5, 8, 3]


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

		let graphWidth = rect.width - Constants.margin * 2 - 4
		let columnXPoint = { (column: Int) -> CGFloat in
			let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
			return CGFloat(column) * spacing + Constants.margin + 2
		}

		let maxValue = graphPoints.max()!
		let graphHeight = rect.height - Constants.topBorder - Constants.bottomBorder
		let columnYPoint = { (graphPoint: Int) -> CGFloat in
			let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
			return graphHeight + Constants.topBorder - y
		}

		UIColor.white.setFill()
		UIColor.white.setStroke()

		let graphPath = UIBezierPath()
		graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(self.graphPoints[0])))

		for i in 1..<self.graphPoints.count {
			let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(self.graphPoints[i]))
			graphPath.addLine(to: nextPoint)
		}

		context.saveGState()

		let clippingPath = graphPath.copy() as! UIBezierPath

		clippingPath.addLine(to: CGPoint(x: columnXPoint(self.graphPoints.count - 1), y: rect.height))
		clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: rect.height))

		clippingPath.addClip()

		let graphStartPoint = CGPoint(x: Constants.margin, y: columnYPoint(maxValue))
		let graphEndPoint = CGPoint(x: Constants.margin, y: self.bounds.height)
		context.drawLinearGradient(gradient, start: graphStartPoint, end: graphEndPoint, options: [])
		context.restoreGState()

		graphPath.lineWidth = 2.0
		graphPath.stroke()

		for i in 0..<self.graphPoints.count {
			var point = CGPoint(x: columnXPoint(i), y: columnYPoint(self.graphPoints[i]))
			point.x -= Constants.circleDiameter / 2
			point.y -= Constants.circleDiameter / 2

			let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
			circle.fill()
		}
	}

}
