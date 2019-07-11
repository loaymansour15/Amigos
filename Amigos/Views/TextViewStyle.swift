//
//  TextFieldStyle.swift
//  Amigos
//
//  Created by Loay on 7/8/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class TextViewStyle: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
    }
    
    private func setUp() {
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.frame = self.bounds
    }
}
