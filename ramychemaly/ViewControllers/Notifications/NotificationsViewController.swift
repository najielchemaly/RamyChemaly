//
//  NotificationsViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/6/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class NotificationsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBadge: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonClose: UIButton!
    
    let tableRowHeight: CGFloat = 45
    
    var notifications: [Notification] = [Notification]()
    var refreshControl: UIRefreshControl = UIRefreshControl()
    var viewDidAppear: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        self.getNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        self.dismissVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !viewDidAppear {
            self.showLoader()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewDidAppear = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func setupTableView() {
        self.tableView.register(UINib.init(nibName: CellIdentifiers.NotificationTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.NotificationTableViewCell)
        self.tableView.tableFooterView = UIView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = self.refreshControl
        } else {
            self.tableView.addSubview(self.refreshControl)
        }
        
        self.refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
    }
    
    @objc func handleRefresh() {
        if self.notifications.count == 0 {
            self.showLoader()
        }
        
        self.getNotifications()
    }
    
    func getNotifications() {
        DispatchQueue.global(qos: .background).async {
            let response = Services.init().getNotifications()
            if response?.status == ResponseStatus.SUCCESS.rawValue {
                if let json = response?.json?.first {
                    if let jsonArray = json["notifications"] as? [NSDictionary] {
                        self.notifications = [Notification]()
                        for json in jsonArray {
                            let notification = Notification.init(dictionary: json)
                            self.notifications.append(notification!)
                        }
                    }
                }
            } else if response?.status == ResponseStatus.UNAUTHORIZED.rawValue {
                self.logout()
            }
            
            self.dummyData()
            
            DispatchQueue.main.async {
                self.hideLoader()
                self.refreshControl.endRefreshing()
                
                if self.notifications.count == 0 {
                    self.addEmptyView(message: "You do not have notifications yet")
                    self.view.bringSubview(toFront: self.labelTitle)
                    self.view.bringSubview(toFront: self.buttonClose)
                } else {
                    self.tableView.reloadData()
                    self.removeEmptyView()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let notification = notifications[indexPath.row]
        if notification.type?.lowercased() == "mass" {
            return tableRowHeight*2
        }
        if let estimatedHeight = notification.rowHeight {
            if indexPath.row == 0 {
                return tableRowHeight/2 + (estimatedHeight < tableRowHeight ? tableRowHeight : estimatedHeight)
            }
            
            return tableRowHeight + (estimatedHeight < tableRowHeight ? tableRowHeight : estimatedHeight)
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.NotificationTableViewCell) as? NotificationTableViewCell {
            cell.selectionStyle = .none
            
            let notification = notifications[indexPath.row]
            cell.labelDescription.text = notification.description
            cell.labelTime.text = notification.date
            
            var height: Int = 0
            if let descriptionHeight = notification.description?.height(width: cell.labelDescription.frame.size.width, font: cell.labelDescription.font!) {
                height += Int(descriptionHeight)
            }
            
            notifications[indexPath.row].rowHeight = CGFloat(height)

            if notification.isRead! {
                cell.backgroundColor = Colors.readNotif
                cell.unreadView.isHidden = true
            } else {
                cell.backgroundColor = Colors.unreadNotif
                cell.unreadView.isHidden = false
            }
            
            if notification.type?.lowercased() == "mass" {
                cell.labelDescription.numberOfLines = 2
                cell.labelDescription.lineBreakMode = .byTruncatingTail
                cell.buttonSeeMore.isHidden = false
                cell.buttonSeeMore.tag = indexPath.row
                cell.buttonSeeMore.addTarget(self, action: #selector(buttonSeeMoreTapped(sender:)), for: .touchUpInside)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    @objc func buttonSeeMoreTapped(sender: UIButton) {
        let notification = notifications[sender.tag]
        if notification.type?.lowercased() == "mass" {
            if let notificationDetailViewController = storyboard?.instantiateViewController(withIdentifier: StoryboardIds.NotificationDetailViewController) as? NotificationDetailViewController {
                notificationDetailViewController.notification = notification
                
                self.present(notificationDetailViewController, animated: true, completion: nil)
            }
        }
    }
    
    func dummyData() {
        self.notifications = [Notification]()
        var description = "This is a long description "
        for var i in (0..<5)
        {
            let notification = Notification()
            notification.description = description
            
            if i < 2 {
                notification.isRead = false
                notification.date = "Just now"
                if i == 0 {
                    notification.description = "'أنا لا أموت بل أدخل الحياة' سنحتفل بالذّبيحة الإلاهيّة لراحة نفس ملاكنا رامي، نهار الخميس الواقع فيه ٨/٣/٢٠١٨ في تمام السّاعة الثّامنة مساءً في كنيسة مار يوسف - سهيله"
                    notification.type = "mass"
                    notification.location = "33.958557, 35.670012"
                    notification.img_url = "https://lh3.googleusercontent.com/-2hUlZ8eF6Xc/UwOk62B6RmI/AAAAAAAAAGI/ltiBlu40KeM/w530-h527-n/1957547_279596762190133_1508036990_n.jpg"
                }
            } else {
                notification.isRead = true
                notification.date = "2 minutes ago"
            }
            
            description.append(description)
            
            self.notifications.append(notification)
        }
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
