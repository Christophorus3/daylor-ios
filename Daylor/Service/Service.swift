//
//  Service.swift
//  Daylor
//
//  Created by Christoph Wottawa on 19.08.19.
//  Copyright © 2019 Christoph Wottawa. All rights reserved.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> ()) {
        guard let url = URL(string: "http://localhost:1337/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else { return }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(posts))
                }
                
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
            }
            
            //print(String(data: data, encoding: .utf8) ?? "")
        }.resume()
    }
    
    func createPost(post: Post, completion: @escaping (Result<Post, Error>) -> ()) {
        guard let url = URL(string: "http://localhost:1337/post") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let data = try! JSONEncoder().encode(post)
        print(String(data: data, encoding: .utf8)!)
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else { return }
            
            do {
                let post = try JSONDecoder().decode(Post.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(post))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
