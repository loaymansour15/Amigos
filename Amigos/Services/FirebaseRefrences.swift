//
//  FirebaseRefrences.swift
//  Amigos
//
//  Created by Loay on 7/7/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseCore
import Firebase

let REF_DB = Database.database().reference()

class FirebaseRefrences {
    
    static var instanse = FirebaseRefrences()
    
    let _DB_REF = REF_DB
    
    let _USER_REF = REF_DB.child("user")
    let _USER_FRIENDS_REF = REF_DB.child("userFriends")
    let _USER_CHATS_REF = REF_DB.child("userChats")
    
    let _CHATS_REF = REF_DB.child("chats")
    let _CHAT_MESSAGES_REF = REF_DB.child("chatMessages")
    let _CHAT_MEMBERS_REF = REF_DB.child("chatMembers")
    
    var listenForNewMessageHandler: DatabaseHandle?
    var listenForUserChatsHandler: DatabaseHandle?
    var listenForChatsHandler: DatabaseHandle?
}
