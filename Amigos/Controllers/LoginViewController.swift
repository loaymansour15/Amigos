//
//  LoginViewController.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: RoundedColoredTextField!
    @IBOutlet weak var passwordTextField: RoundedColoredTextField!
    @IBOutlet weak var loginButton: RoundedGradientButton!
    
    let storyBoard = UIStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // fixing gradient issue
    }

    @IBAction func loginAction(_ sender: Any) {
        
        goToTabBarAndSetAsRoot()
    }
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        
        let forgotPassVC = storyBoard.getForgotPasswordViewController()
        present(forgotPassVC, animated: true)
    }
    
    private func setUpView() {
        
        
    }
}// End Class
