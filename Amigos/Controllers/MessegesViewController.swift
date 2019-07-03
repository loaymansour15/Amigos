//
//  MessegesViewController.swift
//  Amigos
//
//  Created by Loay on 6/30/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class MessegesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var onlineUsers: [UIImage] = [UIImage](repeatElement(UIImage(named: "noProfilePhoto")!, count: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    private func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func setUpCollectionView() {
        
        layout.scrollDirection = .horizontal
        let cellWidth = 80.0
        let cellHeight = 100.0
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }
    
    private func setUp() {
        
        
    }

}

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
            
            return cell!
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnlineUsersCell", for: indexPath) as? MessagesCollectionTableViewCell
            
            setUpCollectionView()
            collectionView.collectionViewLayout = layout
            collectionView.contentInsetAdjustmentBehavior = .never
            
            cell?.imageCell.image = onlineUsers[indexPath.row]
            cell?.userNameCell.text = "First lastName"
            
            return cell!
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        switch indexPath.section {
            
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "OnlineUsersCell", for: indexPath) as? MessagesOnlineUsersTableViewCell
            return cell!
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "MessegesCell", for: indexPath) as? MessagesContextTableViewCell
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
    
}
