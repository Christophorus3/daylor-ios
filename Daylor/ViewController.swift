//
//  ViewController.swift
//  Daylor
//
//  Created by Christoph Wottawa on 19.08.19.
//  Copyright © 2019 Christoph Wottawa. All rights reserved.
//

import UIKit

let cellId = "CellID"

class ViewController: UITableViewController {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Posts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Post", style: .plain, target: self, action: #selector(handleCreatePost))
        
        tableView.register(PostCell.self, forCellReuseIdentifier: cellId)
        
        fetchPosts()
    }

    @objc func handleCreatePost() {
        let post = Post(id: 0, title: "TestPost", body: "New Posts always contain the same text.")
        
        Service.shared.createPost(post: post) { result in
            switch result {
            case .success(let post):
                self.posts.append(post)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPosts() {
        Service.shared.fetchPosts { result in
            switch result {
            case .success(let posts):
                self.posts = posts
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].body
        
        return cell
    }
    
}

