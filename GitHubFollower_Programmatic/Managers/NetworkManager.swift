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
    
    //    func GetFollowers(for username: String, page: Int,completion: @escaping(Result<[Follower],GFError>) -> Void) {
    //        let endPoint = baserUrl + "\(username)/followers?per_page=100&page=\(page)"
    //
    //        guard let url = URL(string: endPoint) else {
    //            completion(.failure(.invalidUsername))
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let _ = error {
    //                completion(.failure(.unableToComplete))
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completion(.failure(.invalidResponse))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(.invalidData))
    //                return
    //            }
    //
    //            do{
    //                let decoder = JSONDecoder()
    //                decoder.keyDecodingStrategy = .convertFromSnakeCase
    //                let followers = try decoder.decode([Follower].self, from: data)
    //                completion(.success(followers))
    //            }catch {
    //                completion(.failure(.invalidData))
    //            }
    //
    //        }
    //        task.resume()
    //    }
    
    
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
        
    
    
//    func getUser(for username: String, completion: @escaping(Result<User,GFError>) -> Void) {
//        let endPoint = baserUrl + "\(username)"
//
//        guard let url = URL(string: endPoint) else {
//            completion(.failure(.invalidUsername))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completion(.failure(.unableToComplete))
//                return
//            }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//
//            do{
//                let decoder = JSONDecoder()
//                let followers = try decoder.decode(User.self, from: data)
//                completion(.success(followers))
//                print("success at user")
//            }catch {
//                completion(.failure(.invalidData))
//            }
//
//        }
//        task.resume()
//    }
    
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
