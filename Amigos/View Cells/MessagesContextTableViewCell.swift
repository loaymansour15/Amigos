//
//  MessagesContextTableViewCell.swift
//  Amigos
//
//  Created by Loay on 6/30/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class MessagesContextTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: RoundedUIImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var timeField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }

}
