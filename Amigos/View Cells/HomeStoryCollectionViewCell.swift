//
//  StoryCollectionViewCell.swift
//  Amigos
//
//  Created by Loay on 6/27/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class HomeStoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        
        setUp()
    }
    
    func setUp() {
        
        RoundedUIImage().setUp(image: self.userImage)
    }
}
