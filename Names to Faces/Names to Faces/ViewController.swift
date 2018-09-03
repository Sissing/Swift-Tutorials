//
//  ViewController.swift
//  Names to Faces
//
//  Created by Ruben Sissing on 03/09/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

	private var people = [Person]()

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.people.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell

		let person = self.people[indexPath.item]
		cell.nameLabel.text = person.name

		if let path = self.getDocumentsDirectory()?.appendingPathComponent(person.image) {
			cell.imageView.image = UIImage(contentsOfFile: path.path)
		}

		return cell
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

		let person = Person(name: "Unknown", image: imageName)
		self.people.append(person)
		self.collectionView.reloadData()

		self.dismiss(animated: true)
	}

	private func getDocumentsDirectory() -> URL? {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths.first
	}
}

extension ViewController: UINavigationControllerDelegate {

}
