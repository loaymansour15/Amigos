//
//  RoundedButton.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class RoundedGradientButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var borderWidth: CGFloat = 2.0
    @IBInspectable var borderColor: UIColor = UIColor.white
    
    @IBInspectable var setGradient: Bool = false
    
    var gradientLayer: CAGradientLayer?
    @IBInspectable var gradientColor1: UIColor = UIColor.white
    @IBInspectable var gradientColor2: UIColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
    }
    
    func setUp() {
        
        if setGradient {
            
            setGradientLayer()
        }
        
        addCornerRadius()
    }
    
    func addCornerRadius() {
        
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func setGradientLayer() {
        
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
        gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer?.cornerRadius = self.cornerRadius
        gradientLayer?.frame = self.bounds
        self.clipsToBounds = true
        self.layer.addSublayer((gradientLayer)!)
    }
    
}
