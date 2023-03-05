//
//  NetworkManager.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 27.01.2023.
//

import UIKit
class NetworkManager {
    static let shared       = NetworkManager()
    private let baserUrl    = "https://api.github.com/users/"
    let cache               = NSCache<NSString, UIImage>()
    let decoder             = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func GetFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endPoint = baserUrl + "\(username)/followers?per_page=100&page=\(page)"
         
        guard let url = URL(string: endPoint) else {
            throw GFError.invalidUsername
        }
        let  (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        do{
            return try decoder.decode([Follower].self, from: data)
        }catch {
            throw GFError.invalidData
        }
    }
    
    func getUser(for username: String) async throws -> User {
        let endPoint = baserUrl + "\(username)"
         
        guard let url = URL(string: endPoint) else {
            throw GFError.invalidUsername
        }
        let (data,response) = try await URLSession.shared.data(from: url)
        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw GFError.invalidResponse
            }
            
            do{
                return try decoder.decode(User.self, from: data)
            }catch {
                throw GFError.invalidData
            }
        }

    func downloadImage(from urlString: String) async -> UIImage? {
        
        let cacheKey = NSString(string: urlString)
        //Checks if the images is already in cache its return image from cache
        if let image = cache.object(forKey: cacheKey){ return image }
        
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            self.cache.setObject(image, forKey: cacheKey) //addes image to cache
            return image
        }catch {
            return nil
        }
    }
}
