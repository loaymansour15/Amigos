//
//  ViewController.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class StartPageViewController: UIViewController {
    
    @IBOutlet weak var bigLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var loginButton: RoundedGradientButton!
    @IBOutlet weak var signUpButton: RoundedGradientButton!
    @IBOutlet weak var continueLabel: UILabel!
    @IBOutlet weak var socialStackButtons: UIStackView!
    
    let storyBoard = UIStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpView()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let loginVC = storyBoard.getLoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        let signUpVC = storyBoard.getSignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func facebookLoginAction(_ sender: Any) {
        
        
    }
    
    @IBAction func twitterLoginAction(_ sender: Any) {
        
        
    }
    
    private func setUpView() {
        
        setCustomBackButton(vc: self)
        setNavigationBarTransparent(vc: self, true)
    }
}// End Class


