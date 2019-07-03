//
//  HomeViewController.swift
//  Amigos
//
//  Created by Loay on 6/26/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var stories: [UIImage] = [UIImage](repeatElement(UIImage(named: "noProfilePhoto")!, count: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUp()
    }
    
    @IBAction func addPostAction(_ sender: Any) {
        
        
    }
    
    private func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
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

}// End CLass

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return stories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addStoryCell", for: indexPath) as? HomeAddStoryCollectionViewCell
            
            setUpCollectionView()
            collectionView.collectionViewLayout = layout
            collectionView.contentInsetAdjustmentBehavior = .never
            
            return cell!
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as? HomeStoryCollectionViewCell
            
            setUpCollectionView()
            collectionView.collectionViewLayout = layout
            collectionView.contentInsetAdjustmentBehavior = .never
            
            cell?.imageCell.image = stories[indexPath.row]
            cell?.nameCell.text = "First lastName"
            
            return cell!
        }
    }
}// End Class

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 20
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        switch indexPath.section {
            
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "searchBarCell", for: indexPath) as? HomeSearchbarTableViewCell
            return cell!
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "topButtonsCell", for: indexPath) as? HomeTopButtonsTableViewCell
            return cell!
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "collectionViewCell", for: indexPath) as? HomeCustomCollectionViewCell
            return cell!
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? HomePostTableViewCell
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return 50
        case 2:
            return 120
        case 3:
            return 450
        default:
            return 0
        }
    }
    
}
