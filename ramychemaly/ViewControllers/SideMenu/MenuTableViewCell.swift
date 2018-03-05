//
//  MenuTableViewCell.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var selectedView: UIView!
    @IBOutlet weak var switchNotification: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectedView.backgroundColor = selected ? Colors.white : UIColor.clear
        titleLabel.font = selected ? Fonts.textFont_Bold : Fonts.textFont_Regular
    }

}
