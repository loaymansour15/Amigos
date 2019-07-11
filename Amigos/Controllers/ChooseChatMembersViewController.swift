//
//  ChooseChatMembersViewController.swift
//  Amigos
//
//  Created by Loay on 7/9/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class ChooseChatMembersViewController: UIViewController {
    
    let userModel = UserModel()
    let userFriendsModel = UserFriendModel()
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var noOfParticipantsLabel: UILabel!
    @IBOutlet weak var startChatButton: UIButton!
    @IBOutlet weak var searchBar: SearchBarViewStyle!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var chatType: ChatType?
    var currentUserID: String?
    var selectedMembers = [UserStruct]()
    var userFriends: [UserStruct]? {
        didSet {
           self.spinner.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentUserID = userModel.currentUserID()
        
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUp()
        loadUserFriends()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startChatAction(_ sender: Any) {
        
        let vc = storyboard?.getUserChatViewController()
        vc?.chatMembers = selectedMembers
        present(vc!, animated: true, completion: nil)
    }
    
    private func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    @objc private func isCheckedButton(_ sender: UIButton) {
        
        let index = sender.tag
        let indexPath = IndexPath(row: index, section: 0)
        
        if sender.currentTitle == "🔘" {
            
            sender.setTitle("☑️", for: .normal)
            
            if let addedFriends = userFriends {
        
                selectedMembers.append(addedFriends[indexPath.row])
            }
        
        } else if sender.currentTitle == "☑️" {
            
            sender.setTitle("🔘", for: .normal)
            
            let member = userFriends![indexPath.row]
            let ind = selectedMembers.firstIndex(where: {$0.userId == member.userId})
            if let found = ind {
                selectedMembers.remove(at: found)
            }
        }
        
        if selectedMembers.count > 0 && startChatButton.isEnabled == false {
            
            startChatButton.isEnabled = true
            startChatButton.alpha = 1
        } else if selectedMembers.count == 0 {
            
            startChatButton.isEnabled = false
            startChatButton.alpha = 0.5
        }
    }
    
    private func setUp() {
        
        setStartChatButton()
    }
    
    private func loadUserFriends() {
        
        spinner.isHidden = false
        spinner.startAnimating()
        userFriendsModel.loadUserFriends(userId: currentUserID!) { (friends) in
            
            self.userFriends = friends
            self.tableView.reloadData()
        }
    }
    
    private func setStartChatButton() {
        
        if chatType == ChatType.group {
            
            startChatButton.isEnabled = false
            startChatButton.alpha = 0.5
        } else {
            
            startChatButton.isHidden = true
        }
    }

}// End Class

extension ChooseChatMembersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = userFriends?.count {
            return count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseFriendsCell", for: indexPath) as? ChooseChatMembersTableViewCell
        
        if let friend = userFriends {
            
            cell?.userName.text = friend[indexPath.row].userName
            cell?.hiddenUserID.text = friend[indexPath.row].userId
            if chatType == .group {
                cell?.isChecked.isHidden = false
                cell?.isChecked.tag = indexPath.row
                cell?.isChecked.addTarget(self, action: #selector(isCheckedButton), for: .touchUpInside)
            } else {
                cell?.isChecked.isHidden = true
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.getUserChatViewController()
        let member = userFriends![indexPath.row]
        vc?.chatMembers = [member]
        present(vc!, animated: true, completion: nil)
    }
    
}

enum ChatType {
    
    case oneToOne
    case group
}
