//
//  ShadowTableViewCell.swift
//  Amigos
//
//  Created by Loay on 6/27/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class ShadowTableViewCell: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
    }
    
    func setUp() {
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.7
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowPath = UIBezierPath(rect: self.layer.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
