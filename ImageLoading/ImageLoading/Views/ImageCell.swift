//
//  ImageCell.swift
//  ImageLoading
//
//  Created by Ramkumar Chintala on 12/05/24.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // Configure cell with image URL
        func configure(with imageUrl: URL) {
            // Load image asynchronously
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }
            }
        }
}
