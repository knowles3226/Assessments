//
//  customCell.swift
//  Assessments
//
//  Created by matthew knowles on 14/04/2018.
//  Copyright © 2018 matthew knowles. All rights reserved.
//

import UIKit
import QuartzCore

class customCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 10
        nameLabel.backgroundColor = UIColor.init(white: 1, alpha: 0.3)
//        nameLabel.layer.borderColor = UIColor.white.cgColor
//        nameLabel.layer.borderWidth = 1.5
        nameLabel.textAlignment = .center
        
        personImage.layer.masksToBounds = true
        personImage.layer.cornerRadius = (personImage.bounds.width/2)
        personImage.layer.borderColor = UIColor.white.cgColor
        personImage.layer.borderWidth = 1.5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
