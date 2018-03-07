//
//  MenuViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class SideMenuViewController: MenuViewController, Storyboardable {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var avatarImageViewCenterXConstraint: NSLayoutConstraint!
    private var gradientLayer = CAGradientLayer()
    
    private var gradientApplied: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Select the initial row
        tableView.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if gradientLayer.superlayer == nil {
            avatarImageViewCenterXConstraint.constant = -(menuContainerViewController?.transitionOptions.visibleContentWidth ?? 0.0)/2
            
            let topColor = Colors.darkBlue
            let bottomColor = Colors.lightBlue
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
            gradientLayer.frame = view.bounds
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    deinit{
        print()
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = menuContainerViewController?.contentViewControllers.count {
            return count + 2
        }
        
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuTableViewCell.self), for: indexPath) as? MenuTableViewCell else {
            preconditionFailure("Unregistered table view cell")
        }
        
        switch indexPath.row {
        case 0:
            cell.switchNotification.isHidden = false
            cell.titleLabel.text = "Allow notifications"
            cell.selectionStyle = .none
        case 1:
            cell.titleLabel.text = "Home"
        case 2:
            cell.titleLabel.text = "Terms & conditions"
        case 3:
            cell.titleLabel.text = "Privacy policy"
        case 4:
            cell.titleLabel.text = "Contact us"
        default:
            break
        }
        
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }

        switch indexPath.row {
        case 0:
            return
        case 1:
            menuContainerViewController.hideSideMenu()
        case 2:
            menuContainerViewController.hideSideMenu()
            WebViewController.comingFrom = WebViewComingFrom.terms
            self.redirectToVC(storyboard: webStoryboard, storyboardId: StoryboardIds.WebViewController, type: .push)
        case 3:
            menuContainerViewController.hideSideMenu()
            WebViewController.comingFrom = WebViewComingFrom.privacy
            self.redirectToVC(storyboard: webStoryboard, storyboardId: StoryboardIds.WebViewController, type: .push)
        case 4:
            self.redirectToVC(storyboard: contactStoryboard, storyboardId: StoryboardIds.ContactUsViewController, type: .present)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
}
