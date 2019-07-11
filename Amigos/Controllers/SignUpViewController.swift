//
//  SignUpViewController.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    let userModel = UserModel()
    
    @IBOutlet weak var fullNameTextField: RoundedColoredTextField!
    @IBOutlet weak var emailTextField: RoundedColoredTextField!
    @IBOutlet weak var password1TextFiled: RoundedColoredTextField!
    @IBOutlet weak var password2TextFiled: RoundedColoredTextField!
    
    @IBOutlet weak var signUpButton: RoundedGradientButton!
    
    let alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpView()
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        signUp()
    }
    
    private func signUp () {
        
        let fullName = fullNameTextField.text
        let email = emailTextField.text
        let pass1 = password1TextFiled.text
        let pass2 = password2TextFiled.text
        
        if let name = fullName, let usEmail = email, let usPass1 = pass1, let usPass2 = pass2 {
            
            if name.isEmpty && usEmail.isEmpty && usPass1.isEmpty && usPass2.isEmpty { // empty fields
                
                return
            }
            if usPass1 != usPass2 { // new passwords not match
                
                alert.showAlertAction(title: "Passwords don't match", message: "Please enter the same password in both fields", action: "OK", vc: self)
                clearFields()
            } else { // authenticate email and password
            
                signUpButton.isEnabled = false
                signUpButton.loadingTitle(title: "Creating Account")
                userModel.createNewUser(name: name, email: usEmail, password: usPass1) { (done, error) in
                    
                    if !done { // error while signup
                        
                        self.alert.showAlertAction(title: "Sign Up Issue!", message: error!, action: "OK", vc: self)
                        self.clearFields()
                    } else { // successful signup continue
                        
                        self.signUpButton.loadingTitle(title: "Registered")
                        let alert = UIAlertController(title: "Successful Sign Up", message: "Your account has been created successfuly, enjoy 😉", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Let's GO", style: .default, handler: { (action) in
                            
                            self.goToTabBarAndSetAsRoot()
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    private func clearFields() {
        
        self.emailTextField.text = ""
        self.password1TextFiled.text = ""
        self.password2TextFiled.text = ""
        self.signUpButton.isEnabled = true
        self.signUpButton.loadingTitle(title: "Sign Up")
    }
    
    private func setUpView() {
        
        clearFields()
    }

}// End Class
