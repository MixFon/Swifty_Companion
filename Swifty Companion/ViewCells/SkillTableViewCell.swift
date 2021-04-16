//
//  SkillTableViewCell.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 20.01.2021.
//

import UIKit

class SkillTableViewCell: UITableViewCell {
    
    @IBOutlet var lavelSkill: UILabel!
    @IBOutlet var nameSkill: UILabel!
    @IBOutlet var progressSkill: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //print(progressSkill.customMirror)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
