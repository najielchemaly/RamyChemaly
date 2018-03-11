//
//  PhotosViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class MediaViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var media: MediaGallery = MediaGallery()
    var comingFrom = MediaComingFrom.none
    
    private var photos: [Photo] = [Photo]()
    private var videos: [Video] = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
        self.setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if comingFrom == MediaComingFrom.photos {
            self.toolbarView.labelTitle.text = media.title?.uppercased()
        } else if comingFrom == MediaComingFrom.videos {
            self.toolbarView.labelTitle.text = media.title?.uppercased()
        }
    }
    
    func initializeViews() {
        if let photos = media.photos {
            self.photos = photos
        }
        if let videos = media.videos {
            self.videos = videos
        }
    }
    
    func setupCollectionView() {
        self.collectionView.register(UINib.init(nibName: CellIdentifiers.ImageCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.ImageCollectionViewCell)
        self.collectionView.register(UINib.init(nibName: CellIdentifiers.VideoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.VideoCollectionViewCell)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if comingFrom == MediaComingFrom.photos {
            return photos.count
        } else if comingFrom == MediaComingFrom.videos {
            return videos.count
        }
        
        return 0
    }
    
    let itemSpacing: CGFloat = 5
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width/3.0)-itemSpacing
        
        if comingFrom == MediaComingFrom.videos {
            return CGSize(width: itemWidth, height: itemWidth+30)
        }
        
        return CGSize(width: itemWidth, height: itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing*2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if comingFrom == MediaComingFrom.photos {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.ImageCollectionViewCell, for: indexPath) as? ImageCollectionViewCell {
                let photo = photos[indexPath.row]
                if let imgThumb = photo.img_thumb {
                    cell.imageViewIcon.kf.setImage(with: URL(string: imgThumb))
                }
                
                cell.imageViewIcon.tag = indexPath.row
                let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(sender:)))
                cell.imageViewIcon.addGestureRecognizer(tap)
            
                return cell
            }
        } else if comingFrom == MediaComingFrom.videos {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.VideoCollectionViewCell, for: indexPath) as? VideoCollectionViewCell {
                let video = videos[indexPath.row]
                if let imgThumb = video.img_thumb {
                    cell.imageViewIcon.kf.setImage(with: URL(string: imgThumb))
                }
                cell.labelTitle.text = video.title
                cell.labelTime.text = video.duration
                
                cell.buttonPlay.tag = indexPath.row
                cell.buttonPlay.addTarget(self, action: #selector(buttonPlayTapped(sender:)), for: .touchUpInside)
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    @objc func imageViewTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            self.showImageFullView(photos: photos, currentIndex: view.tag)
        }
    }
    
    @objc func buttonPlayTapped(sender: UIButton) {
        let video = videos[sender.tag]
        if let link = video.link {
            let linkArray = link.split(separator: "=")
            if let videoId = linkArray.last {
                if let youtubePlayerViewController = storyboard?.instantiateViewController(withIdentifier: StoryboardIds.YoutubePlayerViewController) as? YoutubePlayerViewController {
                    youtubePlayerViewController.videoId = String(videoId)
                    self.present(youtubePlayerViewController, animated: true, completion: nil)
                }
            }
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
