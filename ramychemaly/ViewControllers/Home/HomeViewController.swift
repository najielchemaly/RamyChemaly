//
//  HomeViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import FirebaseMessaging
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
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var imageOverlayView: UIView!
    
    let padding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNotificationBadgeNumber(label: labelBadge)
        labelUsername.text = currentUser.fullname
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
    
    @IBAction func buttonChangeAvatarTapped(_ sender: Any) {
        SelectAvatarViewController.comingFrom = .edit
        self.redirectToVC(storyboard: mainStoryboard, storyboardId: StoryboardIds.SelectAvatarViewController, type: .present)
    }
    
    func initializeViews() {
        let screenWidth = self.view.frame.size.width
        stackViewHeightConstraint.constant = (screenWidth-padding)*1.1
        
        imageViewIcon.layer.cornerRadius = imageViewIcon.frame.size.width/2
        imageOverlayView.layer.cornerRadius = imageOverlayView.frame.size.width/2
        if let avatar = currentUser.avatar {
            let imageUrl = avatar.isEmpty ? defaultBackground : avatar
            imageViewIcon.kf.setImage(with: URL(string: Services.getMediaUrl() + imageUrl!))
        }
        if let avatarName = currentUser.avatar_name {
            imageViewIcon.image = UIImage(named: avatarName)
        }
        
        Messaging.messaging().subscribe(toTopic: "/topics/ramychemalynews")
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
