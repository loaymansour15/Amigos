//
//  ChatModel.swift
//  Amigos
//
//  Created by Loay on 7/8/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import Foundation
import Firebase

struct MessageStruct {
    
    var senderId: String
    var senderName: String
    var message: String
    var time: Double
    var isRead: Bool
}

struct ChatStruct {
    
    var chatID: String
    var senderId: String
    var senderName: String
    var lastMessage: String
    var lastMessageTime: Double
    var isRead: Bool
    var receivers: [UserStruct]
}

struct ChatMembersStruct {
    
    var members: [UserStruct]
}

class ChatModel {
    
    private(set) var receivedChat: [ChatStruct]? {
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "receivedChat"), object: nil)
            print("received chat")
        }
    }
    
    func removeListenForUserChats(userID: String?) {
        
        if let id = userID, !id.isEmpty, let handler1 = FirebaseRefrences.instanse.listenForUserChatsHandler, let handler2 = FirebaseRefrences.instanse.listenForChatsHandler {
            
            FirebaseRefrences.instanse._USER_CHATS_REF.child(id).removeObserver(withHandle: handler1)
            FirebaseRefrences.instanse._CHATS_REF.removeObserver(withHandle: handler2)
            print("Chat handlers removed", handler1, handler2)
        }
    }
    
    func listenForUserChats(userID: String) {
        
        var chats = [String: ChatStruct]()
        
        FirebaseRefrences.instanse.listenForUserChatsHandler = FirebaseRefrences.instanse._USER_CHATS_REF.child(userID).observe(.value) { (snapShot) in
            
            var chatIDs = [String: String]()
            for chatID in (snapShot.children.allObjects as? [DataSnapshot])! {
                chatIDs[chatID.key] = ""
            }
            FirebaseRefrences.instanse.listenForChatsHandler = FirebaseRefrences.instanse._CHATS_REF.observe(.value, with: { (snapShot) in
                
                for chat in (snapShot.children.allObjects as? [DataSnapshot])! {
                    
                    if chatIDs[chat.key] != nil {
                        
                        if let ch = chat.value as? NSDictionary {
                            
                            let senderName = ch["senderName"] as? String
                            let senderID = ch["senderID"] as? String
                            let message = ch["message"] as? String
                            let time = ch["time"] as? Double
                            let isRead = ch["isRead"] as? Bool
                            let receivers = [UserStruct]()
                            let chatInst = ChatStruct(chatID: chat.key, senderId: senderID!, senderName: senderName!, lastMessage: message!, lastMessageTime: time!, isRead: isRead!, receivers: receivers)
                            
                            chats[chat.key] = chatInst
                        }
                    }
                }
                FirebaseRefrences.instanse._CHAT_MEMBERS_REF.observeSingleEvent(of: .value, with: { (snapShot) in
                    
                    for chatID in (snapShot.children.allObjects as? [DataSnapshot])!{
                        
                        if chats[chatID.key] != nil {
                            
                            var receivers = [UserStruct]()
                            for member in (chatID.children.allObjects as? [DataSnapshot])! {
                                
                                let receiver = UserStruct(userId: member.key , userName: member.value as! String)
                                receivers.append(receiver)
                            }
                            chats[chatID.key]?.receivers = receivers
                        }
                    }
                    var result = [ChatStruct]()
                    for v in chats {
                        result.append(v.value)
                    }
                    self.receivedChat = result
                })
            })
        }
    }
    
    func findChatBetween(user1ID: String, user2IDs: [String] ,completion: @escaping(_ chatID: String) -> ()) {
        
        var userChats = [String:Int]()
        var chatID = ""
        FirebaseRefrences.instanse._USER_CHATS_REF.child(user1ID).observeSingleEvent(of: .value) { (snapShot) in
            
            if let value = snapShot.value as? NSDictionary {
                userChats = value as! [String : Int]
                
                self.findChatOfMembers(userChats: userChats, user2IDs: user2IDs, completion: { (chatKey) in
                    
                    chatID = chatKey
                    completion(chatID)
                    
                })
            } else {
                
                completion(chatID)
            }
        } // End first async func
    } // End func
    
    func findChatOfMembers(userChats: [String:Int], user2IDs: [String], completion: @escaping(_ chatID: String) -> ()) {
        
        var cID = ""
        FirebaseRefrences.instanse._CHAT_MEMBERS_REF.observeSingleEvent(of: .value) { (snapShot) in
            
            var foundChat = false
            for chatID in (snapShot.children.allObjects as? [DataSnapshot])! { // loop on all chats
                
                if userChats[chatID.key] != nil, user2IDs.count == chatID.childrenCount { // check if chatID in user chats array
                    for users in (chatID.children.allObjects as? [DataSnapshot])! { // check if all members in user chat members
                        for member in user2IDs {
                            
                            if users.key == member {
                                foundChat = true
                                break
                            } else {
                                foundChat = false
                            }
                        }
                        if !foundChat {
                            break
                        }
                    } // end check for all members and user chat members
                    if foundChat {
                        cID = chatID.key
                        break
                    }
                } // end if
            } // end for loop
            
            completion(cID)
        }
    }
    
    func loadChatMessages(chatID: String, completion: @escaping(_ result: [MessageStruct]) -> ()) {
        
        var chatMessages = [MessageStruct]()
        
        FirebaseRefrences.instanse._CHAT_MESSAGES_REF.child(chatID).observeSingleEvent(of: .value) { (snapShot) in
            
            if let value = snapShot.value as? NSDictionary {
                for val in value.allValues {
                    if let v = val as? NSDictionary{
                        let senderID = v["senderID"] as? String
                        let senderName = v["senderName"] as? String
                        let message = v["message"] as? String
                        let time = v["time"] as? Double
                        let isRead = v["isRead"] as? Bool
                        let chatMessage = MessageStruct(senderId: senderID!, senderName: senderName!, message: message!, time: time!, isRead: isRead!)
                        chatMessages.append(chatMessage)
                    }
                }
            }
            
            completion(chatMessages)
            print("completion load chat messages func called)")
        }
    }
    
    func sendMessage(message: String, chatID: String, senderID: String, senderName: String, time: Double, reciever: [UserStruct], completion: @escaping(_ chatID: String) -> ()) {
        
        let message = ["message":message, "time": time, "senderID": senderID, "senderName": senderName, "isRead": false] as NSDictionary
        
        if chatID == "" { // create new chat
            
            let chats = FirebaseRefrences.instanse._CHATS_REF.childByAutoId()
            
            let key = chats.key!
            
            chats.setValue(message)
            FirebaseRefrences.instanse._CHAT_MESSAGES_REF.child(key).childByAutoId().setValue(message)
            
            var recievers = [String: String]()
            for user in reciever {
                
                recievers[user.userId] = user.userName
            }

            FirebaseRefrences.instanse._CHAT_MEMBERS_REF.child(key).setValue(recievers as NSDictionary)
            
            FirebaseRefrences.instanse._USER_CHATS_REF.child(senderID).child(key).setValue(recievers.count)
            for reciv in recievers {
                FirebaseRefrences.instanse._USER_CHATS_REF.child(reciv.key).child(key).setValue(recievers.count)
            }
            
            completion(key)
        } else { // append to current chat
            
            FirebaseRefrences.instanse._CHATS_REF.child(chatID).updateChildValues(message as! [AnyHashable : Any])
            
            FirebaseRefrences.instanse._CHAT_MESSAGES_REF.child(chatID).childByAutoId().setValue(message)
            
            completion(chatID)
        }
    }
    
    private(set) var receivedMessage: MessageStruct? {
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "receivedMessage"), object: nil)
        }
    }
    
    func listenForNewMessage(chatID: String) {
        
        let myObserver = FirebaseRefrences.instanse
        
        FirebaseRefrences.instanse.listenForNewMessageHandler = myObserver._CHAT_MESSAGES_REF.child(chatID).observe(.childAdded) { (snapShot) in

            if let message = snapShot.value as? NSDictionary {

                let senderID = message["senderID"] as? String
                let senderName = message["senderName"] as? String
                let msg = message["message"] as? String
                let time = message["time"] as? Double
                let isRead = message["isRead"] as? Bool
                
                let chatMessage = MessageStruct(senderId: senderID!, senderName: senderName!, message: msg!, time: time!, isRead: isRead!)
                self.receivedMessage = chatMessage
            }
        }
    }
    
    func removeListenForNewMessagesHandler(chatID: String?) {
        
        if let handler = FirebaseRefrences.instanse.listenForNewMessageHandler, let id = chatID, !id.isEmpty {

            FirebaseRefrences.instanse._CHAT_MESSAGES_REF.child(id).removeObserver(withHandle: handler)
            print("handler removed", handler)
        }
    }
    
}
