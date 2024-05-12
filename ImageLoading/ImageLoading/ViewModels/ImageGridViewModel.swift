//
//  ImageGridViewModel.swift
//  ImageLoading
//
//  Created by Ramkumar Chintala on 12/05/24.
//

import UIKit


// MARK: - ViewModel


class ImageGridViewModel {
    private let imageModel = ImageModel()
    private let imageCacheHandler = ImageCacheHandler.shared
    
    private var imageUrls: [URL] = []
    
    func fetchImageUrls(completion: @escaping () -> Void) {
        imageModel.fetchImageUrls { urls in
            if let urls = urls {
                self.imageUrls = urls
            }
            completion()
        }
    }
    
    func loadImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        imageCacheHandler.loadImage(from: url, completion: completion)
    }
}
