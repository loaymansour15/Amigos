//
//  RoundedColoredTextField.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class RoundedColoredTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    @IBInspectable var cornerRadius: CGFloat = 20 {
        didSet {
            setUp()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
    }
    
    func setUp() {
        
        let color = UIColor.white.withAlphaComponent(0.3)
        self.backgroundColor = color
        self.layer.cornerRadius = self.cornerRadius
        self.frame = self.bounds
        self.clipsToBounds = true
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
