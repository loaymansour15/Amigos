//
//  FriendsTableViewCell.swift
//  Amigos
//
//  Created by Loay on 7/1/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: RoundedUIImage!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }

}
