//
//  ChooseChatMembersTableViewCell.swift
//  Amigos
//
//  Created by Loay on 7/9/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class ChooseChatMembersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImage: RoundedUIImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var isChecked: UIButton!
    @IBOutlet weak var hiddenUserID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }

}
