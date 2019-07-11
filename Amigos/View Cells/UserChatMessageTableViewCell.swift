//
//  UserChatMessageTableViewCell.swift
//  Amigos
//
//  Created by Loay on 7/8/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class UserChatMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }
    
    func adjastMessagePosition(status: messageStatus){
        
        switch status {
        case .incoming:
            self.stackview.alignment = .leading
            message.backgroundColor = UIColor.init(displayP3Red: 247/255, green: 131/255, blue: 97/255, alpha: 1.0)
        case .outgoing:
            self.stackview.alignment = .trailing
            message.backgroundColor = UIColor.init(displayP3Red: 245/255, green: 75/255, blue: 100/255, alpha: 1.0)
        }
    }

}

enum messageStatus {
    
    case incoming
    case outgoing
}
