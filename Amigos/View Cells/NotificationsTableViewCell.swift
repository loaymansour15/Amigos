//
//  NotificationsTableViewCell.swift
//  Amigos
//
//  Created by Loay on 7/4/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: RoundedUIImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }

}
