//
//  MessagesContextTableViewCell.swift
//  Amigos
//
//  Created by Loay on 6/30/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class MessagesContextTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: RoundedUIImage!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var lastMessageCell: UILabel!
    @IBOutlet weak var timeCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }

}
