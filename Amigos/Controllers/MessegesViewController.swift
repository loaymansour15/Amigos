//
//  MessegesViewController.swift
//  Amigos
//
//  Created by Loay on 6/30/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class MessegesViewController: UIViewController {

    let userModel = UserModel()
    let chatModel = ChatModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var isListenerAdded = false
    var currentUserID: String?
    var currentUserName: String?
    var onlineUsers: [UIImage] = [UIImage](repeatElement(UIImage(named: "noProfilePhoto")!, count: 20))
    var chats: [ChatStruct]?{
        didSet{
            spinner.stopAnimating()
        }
    }
    
    let storyBoard = UIStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadUserDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        removeNotifications()
    }
    
    private func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func setUpCollectionView() {
        
        layout.scrollDirection = .horizontal
        let cellWidth = 80.0
        let cellHeight = 80.0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }
    
    private func loadUserDetails() {
        
        spinner.isHidden = false
        spinner.startAnimating()
        currentUserID = userModel.currentUserID()
        userModel.currentUserName(id: currentUserID!, completion: { (fullName) in
            
            self.currentUserName = fullName
            self.setUp()
        })
    }
    
    private func setUp() {
        
        addNotifications()
    }
    
    private func addNotifications() {
        
        chatModel.listenForUserChats(userID: currentUserID!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadChats), name: NSNotification.Name(rawValue: "receivedChat"), object: nil)
    }
    
    private func removeNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "receivedChat"), object: self)
        chatModel.removeListenForUserChats(userID: currentUserID!)
    }
    
    @objc private func loadChats() {
        
        if let gotChats = chatModel.receivedChat {
            
            print(gotChats)
            self.chats = gotChats.sorted(by: {$0.lastMessageTime > $1.lastMessageTime})
            self.tableView.reloadData()
            print("chats loaded")
        }
    }
    
    private func removeDuplicate() {
        
        if var chats = self.chats {
            
            for i in 0 ..< chats.count {
                
                let ind = chats[i].receivers.firstIndex(where: {$0.userId == currentUserID!})
                if ind != nil {
                    chats[i].receivers.remove(at: ind!)
                }
            }
            self.chats = chats
        }
    }
    
    private func getReceiversNames(row: Int) -> String {
        
        var result = ""
        var names = [String]()
        if let chats = self.chats {
            for mem in chats[row].receivers {
                if mem.userId != currentUserID {
                    names.append(mem.userName)
                }
            }
        }
        if names.count > 1 {
           result = ("\(names[0]) and \(names.count-1) More")
        } else {
            result = names[0]
        }
        
        return result
    }

}// End Class

extension MessegesViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return onlineUsers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddNewMessageCell", for: indexPath) as? MessegaesAddNewMessageCollectionViewCell
            
            setUpCollectionView()
            collectionView.collectionViewLayout = layout
            collectionView.contentInsetAdjustmentBehavior = .never
            
            let msgGesture = UITapGestureRecognizer(target: self, action: #selector(newMsg))
            cell?.addMessage.isUserInteractionEnabled = true
            cell?.addMessage.addGestureRecognizer(msgGesture)
            
            return cell!
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnlineUsersCell", for: indexPath) as? MessagesCollectionTableViewCell
            
            setUpCollectionView()
            collectionView.collectionViewLayout = layout
            collectionView.contentInsetAdjustmentBehavior = .never
            
            cell?.userImage.image = onlineUsers[indexPath.row]
            cell?.userName.text = "First lastName"
            
            return cell!
        }
        
    }
    
    @objc private func newMsg() {
        
        let dest = self.storyBoard.getChooseChatMembersViewController()
        
        let alertAction = UIAlertController(title: "Choose Chat Type", message: "", preferredStyle: .actionSheet)
        
        let oneToOneChat = UIAlertAction(title: "One to One Chat", style: .default) { (action) in
            
            dest.chatType = ChatType.oneToOne
            self.present(dest, animated: true, completion: nil)
        }
        
        let groupChat = UIAlertAction(title: "Group Chat", style: .default) { (action) in
            
            dest.chatType = ChatType.group
            self.present(dest, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertAction.addAction(oneToOneChat)
        alertAction.addAction(groupChat)
        alertAction.addAction(cancel)
        present(alertAction, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            if let count = chats?.count {
                return count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnlineUsersCell", for: indexPath) as? MessagesOnlineUsersTableViewCell
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessegesCell", for: indexPath) as? MessagesContextTableViewCell
            if let chat = chats {
                
                cell?.userName.text = getReceiversNames(row: indexPath.row)
                cell?.lastMessage.text = chat[indexPath.row].lastMessage
                cell?.timeField.text = timeStampToDate(timeStamp: chat[indexPath.row].lastMessageTime) 
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 110
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        removeDuplicate()
        
        let vc = storyBoard.getUserChatViewController()
        vc.chatMembers = chats![indexPath.row].receivers
        present(vc, animated: true, completion: nil)
    }
    
}
