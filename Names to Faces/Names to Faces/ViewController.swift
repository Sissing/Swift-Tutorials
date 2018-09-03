//
//  ViewController.swift
//  Names to Faces
//
//  Created by Ruben Sissing on 03/09/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return self.collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
	}

	@IBAction func userDidTapNewPerson(_ sender: Any) {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		self.present(picker, animated: true)
	}
}

extension ViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		guard let image = info[.editedImage] as? UIImage else {
			return
		}

		let imageName = UUID().uuidString
		let imagePath = self.getDocumentsDirectory()?.appendingPathComponent(imageName)

		do {
			if let jpegData = image.jpegData(compressionQuality: 80), let imagePath = imagePath {
				try jpegData.write(to: imagePath)
			} else {
				print("Error(Image): error with compression or impage path unwrapping")
			}
		}
		catch {
			print("Error(Image Write): \(error)")
		}

		self.dismiss(animated: true)
	}

	private func getDocumentsDirectory() -> URL? {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths.first
	}
}

extension ViewController: UINavigationControllerDelegate {

}
