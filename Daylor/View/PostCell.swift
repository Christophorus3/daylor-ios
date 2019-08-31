//
//  PostCell.swift
//  Daylor
//
//  Created by Christoph Wottawa on 19.08.19.
//  Copyright © 2019 Christoph Wottawa. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
