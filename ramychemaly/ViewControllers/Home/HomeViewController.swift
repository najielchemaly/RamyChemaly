//
//  HomeViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class HomeViewController: BaseViewController, SideMenuItemContent, Storyboardable {

    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var buttonAlert: UIButton!
    @IBOutlet weak var buttonBreadOfLife: UIButton!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var buttonBiography: UIButton!
    @IBOutlet weak var buttonDiscography: UIButton!
    @IBOutlet weak var labelBadge: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func buttonMenuTapped(_ sender: Any) {
        self.showSideMenu()
    }
    
    @IBAction func buttonAlertTapped(_ sender: Any) {
        
    }
    
    @IBAction func buttonBreadOfLifeTapped(_ sender: Any) {
        
    }
    
    @IBAction func buttonLogoutTapped(_ sender: Any) {
        let alert = UIAlertController(title: "LOGOUT", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { action in
            self.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonBiographyTapped(_ sender: Any) {
        
    }
    
    @IBAction func buttonDiscographyTapped(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
