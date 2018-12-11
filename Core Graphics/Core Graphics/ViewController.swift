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

	private var currentDrawType = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		self.drawRectangle()
	}

	private func drawRectangle() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
		let image = renderer.image { context in
			let rectangle = CGRect(origin: .zero, size: context.currentImage.size)
			context.cgContext.setFillColor(UIColor.red.cgColor)
			context.cgContext.setStrokeColor(UIColor.black.cgColor)
			context.cgContext.setLineWidth(10)
			context.cgContext.addRect(rectangle)
			context.cgContext.drawPath(using: .fillStroke)
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
		default:
			break
		}
	}

}

