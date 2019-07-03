//
//  SearchbarTableViewCell.swift
//  Amigos
//
//  Created by Loay on 6/28/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class HomeSearchbarTableViewCell: UITableViewCell {

    
    @IBOutlet weak var searchBar: SearchBarViewStyle!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }

}
