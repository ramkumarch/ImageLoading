//
//  ImageCacheHandler.swift
//  ImageLoading
//
//  Created by Ramkumar Chintala on 12/05/24.
//

import UIKit

// MARK: - Image Cache Handler

class ImageCacheHandler {
    static let shared = ImageCacheHandler()
    
    private let memoryCache = NSCache<NSURL, UIImage>()
    private let fileManager = FileManager.default
    
    private init() {}
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = memoryCache.object(forKey: url as NSURL) {
            completion(cachedImage)
        } else {
            DispatchQueue.global().async {
                if let cachedImage = self.loadImageFromDiskCache(url: url) {
                    self.memoryCache.setObject(cachedImage, forKey: url as NSURL)
                    completion(cachedImage)
                } else {
                    if let imageData = try? Data(contentsOf: url),
                       let image = UIImage(data: imageData) {
                        self.memoryCache.setObject(image, forKey: url as NSURL)
                        self.saveImageToDiskCache(image: image, url: url)
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                }
            }
        }
    }
    
    private func loadImageFromDiskCache(url: URL) -> UIImage? {
        let fileName = url.lastPathComponent
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        guard let imageData = try? Data(contentsOf: fileURL),
              let image = UIImage(data: imageData) else {
            return nil
        }
        return image
    }
    
    private func saveImageToDiskCache(image: UIImage, url: URL) {
        let fileName = url.lastPathComponent
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL)
        }
    }
}
