//
//  SavedBlendsTableViewCell.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 8/16/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit

class SavedBlendsTableViewCell: UITableViewCell {

    let topColor = UIColor()
    let bottomColor = UIColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        let view = UIView()
        view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 0.5)
        selectedBackgroundView = view
    }

}
