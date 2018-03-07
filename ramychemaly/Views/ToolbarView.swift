//
//  ToolbarView.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/7/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class ToolbarView: UIView {

    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        if let baseVC = currentVC as? BaseViewController {
            if buttonBack.tag == 0 {
                baseVC.dismissVC()
            } else {
                baseVC.popVC()
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
