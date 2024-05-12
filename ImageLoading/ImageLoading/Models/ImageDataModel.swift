//
//  ImageDataModel.swift
//  ImageLoading
//
//  Created by Ramkumar Chintala on 12/05/24.
//

import Foundation

// MARK: - WelcomeElement
struct ImageDataModel: Codable {
    let id, title: String
    let language: Language
    let thumbnail: Thumbnail
    let mediaType: Int
    let coverageURL: String
    let publishedAt, publishedBy: String
    let backupDetails: BackupDetails?
}
