//
//  NetworkManager.swift
//  ImageLoading
//
//  Created by Ramkumar Chintala on 12/05/24.
//

import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImageUrls(completion: @escaping ([URL]?, Error?) -> Void) {
        guard let apiUrl = URL(string: "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100") else {
            completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let mediaCoverages = jsonResponse?["media_coverages"] as? [[String: Any]] {
                    let imageUrls = mediaCoverages.compactMap { coverage -> URL? in
                        guard let thumbnail = coverage["thumbnail"] as? [String: Any],
                              let domain = thumbnail["domain"] as? String,
                              let basePath = thumbnail["basePath"] as? String,
                              let key = thumbnail["key"] as? String else {
                            return nil
                        }
                        let imageUrlString = "\(domain)/\(basePath)/0/\(key)"
                        return URL(string: imageUrlString)
                    }
                    completion(imageUrls, nil)
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

