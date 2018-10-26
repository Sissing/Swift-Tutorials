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
	private var drawRect = CGRect.zero

	override func draw(_ rect: CGRect) {
		self.drawRect = rect
		let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: Constants.cornerRadiusSize)
		path.addClip()

		let context = UIGraphicsGetCurrentContext()!

		let startPoint = CGPoint.zero
		let endPoint = CGPoint(x: 0, y: self.bounds.height)
		context.drawLinearGradient(self.backgroundGradient(), start: startPoint, end: endPoint, options: [])

		UIColor.white.setFill()
		UIColor.white.setStroke()

		let graphPath = UIBezierPath()
		self.setGraphPoints(graphPath: graphPath)

		context.saveGState()

		self.addClippingPath(graphPath: graphPath)

		let graphStartPoint = CGPoint(x: Constants.margin, y: self.columnYPoint(graphPoint: self.graphPoints.max()!))
		let graphEndPoint = CGPoint(x: Constants.margin, y: self.bounds.height)
		context.drawLinearGradient(self.backgroundGradient(), start: graphStartPoint, end: graphEndPoint, options: [])
		context.restoreGState()

		graphPath.lineWidth = 2.0
		graphPath.stroke()

		self.drawColumnPointDots()
	}

	private func backgroundGradient() -> CGGradient {
		let colors = [self.startColor.cgColor, self.endColor.cgColor] as CFArray

		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let colorLocations: [CGFloat] = [0.0, 1.0]

		return CGGradient(colorsSpace: colorSpace, colors: colors, locations: colorLocations)!
	}

	private func columnXPoint(column: Int) -> CGFloat {
		let graphWidth = self.drawRect.width - Constants.margin * 2 - 4

		let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
		return CGFloat(column) * spacing + Constants.margin + 2
	}

	private func columnYPoint(graphPoint: Int) -> CGFloat {
		let graphHeight = self.drawRect.height - Constants.topBorder - Constants.bottomBorder
		let y = CGFloat(graphPoint) / CGFloat(self.graphPoints.max()!) * graphHeight
		return graphHeight + Constants.topBorder - y
	}

	private func setGraphPoints(graphPath: UIBezierPath) {
		graphPath.move(to: CGPoint(x: self.columnXPoint(column: 0), y: self.columnYPoint(graphPoint: self.graphPoints[0])))

		for i in 1..<self.graphPoints.count {
			let nextPoint = CGPoint(x: self.columnXPoint(column: i), y: self.columnYPoint(graphPoint: self.graphPoints[i]))
			graphPath.addLine(to: nextPoint)
		}
	}

	private func addClippingPath(graphPath: UIBezierPath) {
		let clippingPath = graphPath.copy() as! UIBezierPath

		clippingPath.addLine(to: CGPoint(x: self.columnXPoint(column: self.graphPoints.count - 1), y: self.drawRect.height))
		clippingPath.addLine(to: CGPoint(x: self.columnXPoint(column: 0), y: self.drawRect.height))

		clippingPath.addClip()
	}

	private func drawColumnPointDots() {
		for i in 0..<self.graphPoints.count {
			var point = CGPoint(x: self.columnXPoint(column: i), y: columnYPoint(graphPoint: self.graphPoints[i]))
			point.x -= Constants.circleDiameter / 2
			point.y -= Constants.circleDiameter / 2

			let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
			circle.fill()
		}
	}

}
