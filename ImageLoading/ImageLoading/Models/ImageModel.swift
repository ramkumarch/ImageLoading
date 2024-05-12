//
//  ImageModel.swift
//  ImageLoading
//
//  Created by Ramkumar Chintala on 12/05/24.
//

import Foundation

// MARK: - Model

class ImageModel {
    private let networkManager = NetworkManager.shared
    
    func fetchImageUrls(completion: @escaping ([URL]?) -> Void) {
        networkManager.fetchImageUrls { imageUrls, error in
            if let error = error {
                print("Error fetching image URLs: \(error.localizedDescription)")
                completion(nil)
            } else {
                completion(imageUrls)
            }
        }
    }
}
