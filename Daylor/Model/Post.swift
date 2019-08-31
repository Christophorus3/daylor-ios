//
//  Post.swift
//  Daylor
//
//  Created by Christoph Wottawa on 19.08.19.
//  Copyright © 2019 Christoph Wottawa. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}
