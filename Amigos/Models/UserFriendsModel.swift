//
//  UserFriendsModel.swift
//  Amigos
//
//  Created by Loay on 7/9/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import Foundation
import Firebase

class UserFriendModel {
    
    func loadUserFriends(userId: String, completion: @escaping(_ result: [UserStruct]) -> ()){
        
        var userFriends = [UserStruct]()
        
        FirebaseRefrences.instanse._USER_FRIENDS_REF.child(userId).observeSingleEvent(of: .value) { (snapShot) in

            if let value = snapShot.value as? NSDictionary {
                for v in value {
                    
                    let friendI = UserStruct(userId: v.key as! String, userName: v.value as! String)
                    userFriends.append(friendI)
                }
            }
            completion(userFriends)
        }
    }
}
