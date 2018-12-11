//
//  ViewController.swift
//  Core Graphics
//
//  Created by Ruben Sissing on 11/12/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

	@IBOutlet private var imageView: UIImageView!

	private let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
	private let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
	private var currentDrawType = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		self.drawRectangle()
	}

	private func drawRectangle() {
		let image = self.renderer.image { context in
			let rectangle = self.rectangle
			context.cgContext.setFillColor(UIColor.red.cgColor)
			context.cgContext.setStrokeColor(UIColor.black.cgColor)
			context.cgContext.setLineWidth(10)
			context.cgContext.addRect(rectangle)
			context.cgContext.drawPath(using: .fillStroke)
		}
		self.imageView.image = image
	}

	private func drawCircle() {
		let image = self.renderer.image { context in
			let rectangle = self.rectangle
			context.cgContext.setFillColor(UIColor.red.cgColor)
			context.cgContext.setStrokeColor(UIColor.black.cgColor)
			context.cgContext.setLineWidth(10)
			context.cgContext.addEllipse(in: rectangle)
			context.cgContext.drawPath(using: .fillStroke)
		}
		self.imageView.image = image
	}

	private func drawCheckerboard() {
		let image = self.renderer.image { context in
			context.cgContext.setFillColor(UIColor.black.cgColor)

			for row in 0..<8 {
				for col in 0..<8 {
					if (row + col) % 2 == 0 {
						context.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
					}
				}
			}
		}
		self.imageView.image = image
	}

	private func drawRotatedSquares() {
		let image = self.renderer.image { context in
			context.cgContext.translateBy(x: context.currentImage.size.width / 2, y: context.currentImage.size.height / 2)
			let rotations = 16
			let amount = Double.pi / Double(rotations)

			for _ in 0..<rotations {
				context.cgContext.rotate(by: CGFloat(amount))
				let size = CGSize(width: 256, height: 256)
				let origin = CGPoint(x: -(size.width / 2), y: -(size.height / 2))
				context.cgContext.addRect(CGRect(origin: origin, size: size))
				context.cgContext.setStrokeColor(UIColor.black.cgColor)
				context.cgContext.strokePath()
			}
		}
		self.imageView.image = image
	}

	private func drawLines() {
		let image = self.renderer.image { context in
			let size = CGSize(width: context.currentImage.size.width / 2, height: context.currentImage.size.height / 2)
			var first = true
			var length: CGFloat = size.width

			context.cgContext.translateBy(x: size.width, y: size.height)

			for _ in 0..<Int(size.width) {
				context.cgContext.rotate(by: CGFloat.pi / 2)
				if first {
					context.cgContext.move(to: CGPoint(x: length, y: 50))
					first = false
				} else {
					context.cgContext.addLine(to: CGPoint(x: length, y: 50))
				}

				length *= 0.99
			}

			context.cgContext.setStrokeColor(UIColor.black.cgColor)
			context.cgContext.strokePath()
		}
		self.imageView.image = image
	}

	@IBAction func redrawTapped(_ sender: Any) {
		self.currentDrawType += 1

		if self.currentDrawType > 5 {
			self.currentDrawType = 0
		}

		switch currentDrawType {
		case 0:
			self.drawRectangle()
		case 1:
			self.drawCircle()
		case 2:
			self.drawCheckerboard()
		case 3:
			self.drawRotatedSquares()
		case 4:
			self.drawLines()
		default:
			break
		}
	}

}

