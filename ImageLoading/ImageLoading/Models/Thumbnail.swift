//
//  Thumbnail.swift
//  ImageLoading
//
//  Created by Ramkumar Chintala on 12/05/24.
//

import Foundation

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let id: String
    let version: Int
    let domain: String
    let basePath: String
    let key: Key
    let qualities: [Int]
    let aspectRatio: Double
}

enum Key: String, Codable {
    case imageJpg = "image.jpg"
}
