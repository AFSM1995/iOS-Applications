//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Álvaro Santillan on 12/26/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBubble.layer.cornerRadius = messageBubble.frame.height / 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}