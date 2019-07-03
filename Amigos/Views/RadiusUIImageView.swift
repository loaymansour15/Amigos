//
//  RadiusUIImageView.swift
//  Amigos
//
//  Created by Loay on 6/27/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class RadiusUIImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
    }
    
    func setUp() {
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
    }
}
