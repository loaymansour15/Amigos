//
//  UIAlertControllerExtension.swift
//  Amigos
//
//  Created by Loay on 7/7/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func showAlertAction(title: String, message: String, action: String, vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
