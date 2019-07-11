//
//  LoginViewController.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let userModel = UserModel()
    
    @IBOutlet weak var emailTextField: RoundedColoredTextField!
    @IBOutlet weak var passwordTextField: RoundedColoredTextField!
    @IBOutlet weak var loginButton: RoundedGradientButton!
    
    let storyBoard = UIStoryboard()
    
    let alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpView()
    }

    @IBAction func loginAction(_ sender: Any) {
        
        login()
    }
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        
        let forgotPassVC = storyBoard.getForgotPasswordViewController()
        present(forgotPassVC, animated: true)
    }
    
    private func login() {
        
        let email = emailTextField.text
        let pass = passwordTextField.text
        
        if let usEmail = email, let usPass = pass {
            
            if usEmail.isEmpty && usPass.isEmpty { // empty fields
                
                return
            } else { // authenticate email and password
                
                loginButton.isEnabled = false
                loginButton.loadingTitle(title: "Logging In")
                userModel.signInUser(email: usEmail, password: usPass) { (done, error) in
                    
                    if !done { // error while login
                        
                        self.alert.showAlertAction(title: "Log In Issue!", message: error!, action: "OK", vc: self)
                        self.setFieldsAndButton()
                    } else { // successful login continue
                        
                        self.loginButton.loadingTitle(title: "Logged In")
                        self.goToTabBarAndSetAsRoot()
                    }
                }
            }
        }
    }
    
    private func setFieldsAndButton() {
        
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.loginButton.isEnabled = true
        self.loginButton.loadingTitle(title: "Log In")
    }
    
    private func setUpView() {
        
        setFieldsAndButton()
    }
}// End Class
