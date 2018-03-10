//
//  SelectAvatarViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import FSPagerView

class SelectAvatarViewController: BaseViewController, FSPagerViewDataSource, FSPagerViewDelegate {

    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var pagerHeightConstraint: NSLayoutConstraint!
    
    var selectedAvatar: UIImage!
    var avatars: [Avatar] = [
        Avatar.init(image: #imageLiteral(resourceName: "ramy1")),
        Avatar.init(image: #imageLiteral(resourceName: "ramy2")),
        Avatar.init(image: #imageLiteral(resourceName: "ramy3")),
        Avatar.init(image: #imageLiteral(resourceName: "ramy4")),
        Avatar.init(image: #imageLiteral(resourceName: "ramy5"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupPagerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.toolbarView.labelTitle.text = "SELECT YOUR AVATAR"
        
        self.toolbarView.buttonBack.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        self.toolbarView.buttonBack.tag = 1
    }
    
    @IBAction func buttonStartTapped(_ sender: Any) {
        if selectedAvatar != nil {
            
        } else {
            self.showAlertView(message: "Do not forget to pick your favorite picture :D")
        }
    }
    
    func setupPagerView() {
        self.pagerView.transformer = FSPagerViewTransformer(type: .ferrisWheel)
        self.pagerView.register(UINib.init(nibName: CellIdentifiers.AvatarCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.AvatarCollectionViewCell)
        
        self.pagerHeightConstraint.constant = self.view.frame.size.width
        let width = self.pagerHeightConstraint.constant/2
        self.pagerView.itemSize = CGSize(width: width, height: width)
        
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.AvatarCollectionViewCell, at: index) as? AvatarCollectionViewCell {
            
            cell.contentView.layer.shadowRadius = 0
            
            let avatar = avatars[index]
            if let image = avatar.image {
                cell.imageViewAvatar.image = image
            }
            
            cell.checkBox.tintColor = Colors.appBlue
            cell.checkBox.secondaryTintColor = Colors.white
            cell.checkBox.stateChangeAnimation = .fill
            cell.checkBox.isUserInteractionEnabled = false
            
            if avatar.is_selected! {
                cell.checkBox.setCheckState(.checked, animated: true)
                cell.checkBox.isHidden = false
            } else {
                cell.checkBox.setCheckState(.unchecked, animated: true)
                cell.checkBox.isHidden = true
            }
            
            return cell
        }
        
        return FSPagerViewCell()
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let avatar = avatars[index]
        if let image = avatar.image {
            self.selectedAvatar = image
        }
        
        self.updateSelectedAvatar(index: index)
        self.pagerView.reloadData()
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return avatars.count
    }
    
    func updateSelectedAvatar(index: Int) {
        for avatar in avatars {
            avatar.is_selected = false
        }
        avatars[index].is_selected = true
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
