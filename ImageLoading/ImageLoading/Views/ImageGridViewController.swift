//
//  ImageGridViewController.swift
//  ImageLoading
//
//  Created by Ramkumar Chintala on 12/05/24.
//

import UIKit

class ImageGridViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = ImageGridViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Fetch image URLs
        viewModel.fetchImageUrls {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ImageGridViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let imageUrl = viewModel.imageUrls[indexPath.item]
        viewModel.loadImage(for: imageUrl) { image in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        return cell
    }
}

