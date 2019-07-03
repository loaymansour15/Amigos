//
//  roundedView.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            setUp()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
    }
    
    func setUp() {
        
        self.layer.cornerRadius = self.cornerRadius
        self.clipsToBounds = true
        self.frame = self.bounds
    }
}
