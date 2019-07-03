//
//  HomeTableViewCell.swift
//  Amigos
//
//  Created by Loay on 6/27/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class HomePostTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }

}
