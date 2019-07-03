//
//  TopButtonsTableViewCell.swift
//  Amigos
//
//  Created by Loay on 6/28/19.
//  Copyright © 2019 Loay Productions. All rights reserved.
//

import UIKit

class HomeTopButtonsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pictureButton: RoundedUIImage!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var logoButton: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }

}
