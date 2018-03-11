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
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    let padding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenWidth = self.view.frame.size.width
        self.stackViewHeightConstraint.constant = (screenWidth-padding)*1.1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func buttonMenuTapped(_ sender: Any) {
        self.showSideMenu()
    }
    
    @IBAction func buttonAlertTapped(_ sender: Any) {
        self.redirectToVC(storyboard: mainStoryboard, storyboardId: StoryboardIds.NotificationsViewController, type: .present)
    }
    
    @IBAction func buttonBreadOfLifeTapped(_ sender: Any) {
        self.redirectToVC(storyboard: mainStoryboard, storyboardId: StoryboardIds.BreadOfLifeViewController, type: .present)
    }
    
    @IBAction func buttonLogoutTapped(_ sender: Any) {
        self.showAlertView(title: "LOGOUT", message: "Are you sure you want to logout?", cancelTitle: "Cancel", doneTitle: "Logout")
        
        if let alertView = self.alertView {
            alertView.buttonDone.addTarget(self, action: #selector(self.logout), for: .touchUpInside)
        }
    }
    
    @IBAction func buttonBiographyTapped(_ sender: Any) {
        self.redirectToVC(storyboard: mainStoryboard, storyboardId: StoryboardIds.BiographyViewController, type: .present)
    }
    
    @IBAction func buttonDiscographyTapped(_ sender: Any) {
        self.redirectToVC(storyboard: mainStoryboard, storyboardId: StoryboardIds.DiscographyViewController, type: .present)
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
