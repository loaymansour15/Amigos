//
//  RoundedUIImage.swift
//  Amigos
//
//  Created by Loay on 6/27/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class RoundedUIImage: UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp(image: self)
    }
    
    func setUp(image: UIImageView) {
        
        let sublayer: CALayer = CALayer()
        sublayer.frame = CGRect(x: 1, y: 1, width: image.frame.width - 2, height: image.frame.height - 2)
        sublayer.backgroundColor = UIColor.clear.cgColor
        sublayer.borderColor = UIColor(red: 37/255.0, green: 42/255.5, blue: 57/255.0, alpha: 1.0).cgColor
        sublayer.borderWidth = 3.0
        sublayer.cornerRadius = (image.frame.width - 2) / 2
        image.layer.addSublayer(sublayer)
        image.layer.cornerRadius = image.frame.width / 2
        image.clipsToBounds = true
        image.layer.borderWidth = 2.0
        image.layer.borderColor = borderColor.cgColor
    }
}
