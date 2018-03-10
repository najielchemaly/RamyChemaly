//
//  ImageFullView.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/7/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import FSPagerView

class ImageFullView: UIView, FSPagerViewDelegate, FSPagerViewDataSource {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var pagerTopConstraint: NSLayoutConstraint!
    
    private var photos: [Photo] = [Photo]()
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        if let baseVC = currentVC as? BaseViewController {
            baseVC.hideImageFullView()
        }
    }
    
    func setupPagerView(photos: [Photo]) {
        self.photos = photos
        
        self.pagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
        self.pagerView.register(UINib.init(nibName: CellIdentifiers.ImageFullCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.ImageFullCollectionViewCell)
        
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.photos.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.ImageFullCollectionViewCell, at: index) as? ImageFullCollectionViewCell {
            
            let photo = photos[index]
            // TODO change to img_url
            if let imgUrl = photo.img_thumb {
                cell.imageViewIcon.kf.setImage(with: URL(string: imgUrl))
            }
            
            return cell
        }
        
        return FSPagerViewCell()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
