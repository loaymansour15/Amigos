//
//  StoryCollectionViewCell.swift
//  Amigos
//
//  Created by Loay on 6/27/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class HomeStoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nameCell: UILabel!
    
    override func awakeFromNib() {
        
        setUp()
    }
    
    func setUp() {
        
        RoundedUIImage().setUp(image: self.imageCell)
    }
}
