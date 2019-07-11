//
//  UserChatViewController.swift
//  Amigos
//
//  Created by Loay on 7/8/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class UserChatViewController: UIViewController {

    var userModel = UserModel()
    var chatModel = ChatModel()
    
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var searchBar: SearchBarViewStyle!
    
    @IBOutlet weak var recieverImage: RoundedUIImage!
    @IBOutlet weak var recieverName: UILabel!
    @IBOutlet weak var recieverIsStatus: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgAttachmentButton: UIButton!
    @IBOutlet weak var msgText: UITextView!
    @IBOutlet weak var msgSendButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var currentUserID: String?
    var currentUserName: String?
    var chatID: String? {
        didSet {
            if let id = self.chatID, !id.isEmpty, !self.islistnerAdded {
                self.addNotifications()
                print("listener attached")
            }
        }
    }
    var chatMembers = [UserStruct]()
    var chatMessges: [MessageStruct]?
    var islistnerAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setUpShowHideSwipeGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getUserDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        removeNotifications()
    }
    
    @IBAction func closeChatAction(_ sender: Any) {
        
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendMessageAction(_ sender: Any) {
        
        sendMessage()
    }
    
    private func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func getUserDetails() {
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        currentUserID = userModel.currentUserID()
        userModel.currentUserName(id: currentUserID!, completion: { (fullName) in
            
            self.currentUserName = fullName
            self.setUp()
        })
    }
    
    private func setUp() {
        
        setSendMsgButton()
        setRecieverDetails()
        getChatMessages()
    }
    
    private func setSendMsgButton() {
        
        self.msgSendButton.isEnabled = false
        self.msgSendButton.alpha = 0.5
    }
    
    private func setRecieverDetails() {
        
        recieverName.text = getReceiversNames()
    }
    
    private func formChatMembers() -> [String] {
        
        var members = [String]()
        members.append(currentUserID!)
        for m in chatMembers{
            members.append(m.userId)
        }
        
        return members
    }
    
    private func getChatMessages() {
        
        let members = formChatMembers()

        chatModel.findChatBetween(user1ID: currentUserID!, user2IDs: members) { (chatID) in
            
            self.chatID = chatID
            self.spinner.stopAnimating()
            
            self.msgSendButton.isEnabled = true
            self.msgSendButton.alpha = 1.0
        }
        
    }
    
    private func sendMessage() {
        
        if let message = msgText.text, !message.isEmpty {
            
            chatModel.sendMessage(message: message, chatID: chatID!, senderID: currentUserID!, senderName: currentUserName!, time: getCurrentTimeStamp(), reciever: getChatMemebers()) { (cID) in
                
                if let id = self.chatID, id.isEmpty {
                    
                    self.chatID = cID
                    print("set chat id")
                }
            }
            msgText.text = ""
        }
    }
    
    private func getChatMemebers() -> [UserStruct]{
        
        var members = chatMembers
        let currentUser = UserStruct(userId: currentUserID!, userName: currentUserName!)
        members.append(currentUser)
        
        return members
    }
    
    private func getCurrentTimeStamp() -> Double {
        
        let timestamp = NSDate().timeIntervalSince1970
        
        return timestamp
    }
    
    private func reloadTable() {
        
        if chatMessges != nil {
            
            self.chatMessges = self.chatMessges!.sorted(by: {$0.time < $1.time})
            
            if self.chatMessges!.count > 0 {
                self.tableView.reloadData()
                let indexPath = NSIndexPath(row: self.chatMessges!.count-1, section: 0)
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: false)
            }
        }
    }
    
    private func getReceiversNames() -> String {
        
        var result = ""
        
        if chatMembers.count > 1 {
            result = ("\(chatMembers[0].userName) and \(chatMembers.count-1) More")
        } else {
            result = chatMembers[0].userName
        }
        
        return result
    }
    
    private func addNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNewMessage), name: NSNotification.Name(rawValue: "receivedMessage"), object: nil)
        islistnerAdded = true
        self.chatModel.listenForNewMessage(chatID: self.chatID!)
    }
    
    private func removeNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "receivedMessage"), object: self)
        islistnerAdded = false
        chatModel.removeListenForNewMessagesHandler(chatID: self.chatID)
        print("removed listiner")
    }
    
    @objc private func getNewMessage() {
        
        if let msg = chatModel.receivedMessage {
            
            if chatMessges == nil {
                self.chatMessges = [MessageStruct]()
            }

            self.chatMessges?.append(msg)
            self.reloadTable()
        }
    }
    
}// End Class

extension UserChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = chatMessges?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? UserChatMessageTableViewCell

        if let msgs = chatMessges {
            
            cell?.senderName.text = msgs[indexPath.row].senderName
            cell?.message.text = msgs[indexPath.row].message
            cell?.time.text = timeStampToDate(timeStamp: msgs[indexPath.row].time)
            if msgs[indexPath.row].senderId == currentUserID{
                cell?.adjastMessagePosition(status: .outgoing)
            }else{
                cell?.adjastMessagePosition(status: .incoming)
            }
        }
        
        return cell!
    }
    
}

extension UserChatViewController: UIGestureRecognizerDelegate {
    
    private func setUpShowHideSwipeGesture() {
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(hideStack))
        upSwipe.direction = .up
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(showStack))
        downSwipe.direction = .down
        upSwipe.delegate = self
        downSwipe.delegate = self
        self.tableView.addGestureRecognizer(upSwipe)
        self.tableView.addGestureRecognizer(downSwipe)
    }
    
    @objc private func hideStack() {

        UIView.animate(withDuration: 0.2) {
            
            self.searchBar.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func showStack() {
        
        UIView.animate(withDuration: 0.2) {
            
            self.searchBar.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}
