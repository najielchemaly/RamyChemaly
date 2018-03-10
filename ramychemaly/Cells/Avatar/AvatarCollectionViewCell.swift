//
//  AvatarCollectionViewCell.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import FSPagerView
import M13Checkbox

class AvatarCollectionViewCell: FSPagerViewCell {

    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var checkBox: M13Checkbox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
