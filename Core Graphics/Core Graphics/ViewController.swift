//
//  ViewController.swift
//  Core Graphics
//
//  Created by Ruben Sissing on 11/12/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
		default:
			break
		}
	}

}

