//
//  SignUpViewController.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: RoundedColoredTextField!
    @IBOutlet weak var password1TextFiled: RoundedColoredTextField!
    @IBOutlet weak var password2TextFiled: RoundedColoredTextField!
    
    @IBOutlet weak var signUpButton: RoundedGradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // fixing gradient issue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpView()
    }
    
    @IBAction func signUpAction(_ sender: Any) {
    }
    
    private func setUpView() {
        
        
    }

}// End Class
