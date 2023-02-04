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
    
    private init() { }
    
    func GetFollowers(for username: String, page: Int,completion: @escaping(Result<[Follower],GFError>) -> Void) {
        let endPoint = baserUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            }catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getUser(for username: String, completion: @escaping(Result<User,GFError>) -> Void) {
        let endPoint = baserUrl + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let followers = try decoder.decode(User.self, from: data)
                completion(.success(followers))
                print("success at user")
            }catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        //Checks if the images is already in cache its return image from cache
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                    error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200,
                    let data = data,
                    let image = UIImage(data: data) else {
                completed(Images.ghLogo)
                return
            }
            self.cache.setObject(image, forKey: cacheKey) //addes image to cache
            completed(image)
        }
        task.resume()
    }
}
