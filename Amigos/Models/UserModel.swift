//
//  UserModel.swift
//  Amigos
//
//  Created by Loay on 7/7/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import Foundation
import Firebase

struct UserStruct {
    
    var userId: String
    var userName: String
    
    init(userId: String, userName: String) {
        
        self.userId = userId
        self.userName = userName
    }
}

class UserModel {
    
    func currentUserID() -> String {
        
        return (Auth.auth().currentUser?.uid)!
    }
    
    func currentUserName(id: String, completion: @escaping(_ fullName: String) -> ()) {
        
        var fullName = ""

        FirebaseRefrences.instanse._USER_REF.child(id).observeSingleEvent(of: .value) { (snapShot) in
            
            if let value = snapShot.value as? NSDictionary {
                
                fullName = value["full name"] as! String
            }
            completion(fullName)
        }
    }
    
    func createNewUser(name: String, email: String, password: String, completion: @escaping (_ result: Bool, _ error: String?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let foundError = error {
                
                if let err = AuthErrorCode(rawValue: foundError._code) {
                    
                    switch err {
                        
                    case .emailAlreadyInUse:
                        completion(false, "This email you are trying to sign up with already exists")
                    case .weakPassword:
                        completion(false, "Weak password, please enter a password more than 5 characters")
                    case.invalidEmail:
                        completion(false, "This email is invalid")
                    default:
                        completion(false, "Please try again later!")
                    }
                }
            } else {
                
                // Save user data to database
                self.saveNewUserAuth(email: email, name: name)
                completion(true, nil)
            }
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (_ result: Bool, _ error: String?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if let foundError = error {
                    
                    if let err = AuthErrorCode(rawValue: foundError._code) {
                        
                        switch err {
                            
                        case .userNotFound:
                            completion(false, "User not found")
                        case .wrongPassword:
                            completion(false, "Wrong password")
                        case.invalidEmail:
                            completion(false, "This email is invalid")
                        default:
                            completion(false, "Please try again later!")
                        }
                    }
                } else {
                    
                    completion(true, nil)
                }
        }
    }
    
    private func saveNewUserAuth(email: String, name: String) {
        
        let data = ["email": email, "full name": name]
        FirebaseRefrences.instanse._USER_REF.child(currentUserID()).setValue(data)
    }
}
