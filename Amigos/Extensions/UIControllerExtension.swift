//
//  UIControllerExtension.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showNavigationBar(vc: UIViewController) {
        
        vc.navigationController?.isNavigationBarHidden = false
    }
    
    func hideNavigationBar(vc: UIViewController) {
        
        vc.navigationController?.isNavigationBarHidden = true
    }
    
    func setCustomBackButton(vc: UIViewController) {
        
        let backImage = UIImage(named: "backIcon")?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backImage, style: .done, target: nil, action: nil)
        vc.navigationItem.backBarButtonItem = backButton
        vc.navigationController?.navigationBar.backIndicatorImage = UIImage()
        vc.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
    
    func setNavigationBarTransparent(vc: UIViewController,_ set: Bool){
    
        if set {
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.navigationController?.navigationBar.isTranslucent = true
            vc.navigationController?.view.backgroundColor = .clear
        }
    }
    
    func goToTabBarAndSetAsRoot() {
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabBarController")
        
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
        }, completion: nil)
        
    }
    
    func goToStartViewAndSetAsRoot() {
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "navigationController")
        
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: .transitionFlipFromRight, animations: {
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
        }, completion: nil)
        
    }
    
    func timeStampToDate(timeStamp: Double) -> String {
        
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
