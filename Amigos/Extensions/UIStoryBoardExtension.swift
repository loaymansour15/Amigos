//
//  UIStoryBoardExtension.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func getMain() -> UIStoryboard{
        
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func getStartPageViewController() -> StartPageViewController {
        
        return (getMain().instantiateViewController(withIdentifier: "StartPageViewController") as? StartPageViewController)!
    }
    
    func getLoginViewController() -> LoginViewController {
        
        return (getMain().instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController)!
    }
    
    func getSignUpViewController() -> SignUpViewController {
        
        return (getMain().instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController)!
    }
    
    func getForgotPasswordViewController() -> ForgotPasswordViewController {
        
        return (getMain().instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController)!
    }
    
    func getHomeViewController() -> HomeViewController {
        
        return (getMain().instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)!
    }
    
    func getMessegesViewController() -> MessegesViewController {
        
        return (getMain().instantiateViewController(withIdentifier: "MessegesViewController") as? MessegesViewController)!
    }
    
    func getUserChatViewController() -> UserChatViewController {
        
        return (getMain().instantiateViewController(withIdentifier: "UserChatViewController") as? UserChatViewController)!
    }
    
    func getChooseChatMembersViewController() -> ChooseChatMembersViewController {
        
        return (getMain().instantiateViewController(withIdentifier: "ChooseChatMembersViewController") as? ChooseChatMembersViewController)!
    }
    
}
