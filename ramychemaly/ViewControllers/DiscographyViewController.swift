//
//  DiscographyViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/7/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class DiscographyViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var buttonImages: UIButton!
    @IBOutlet weak var buttonVideos: UIButton!
    @IBOutlet weak var buttonSocials: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonAudios: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
    
    var socials: [Social] = [Social]()
    var mediaGallery: [MediaGallery] = [MediaGallery]()
    
    var photosGallery: [MediaGallery] = [MediaGallery]()
    var videosGallery: [MediaGallery] = [MediaGallery]()
    var audios: [Audio] = [Audio]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dummyData()
        self.initializeViews()
        self.setupCollectionView()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.toolbarView.labelTitle.text = "DISCOGRAPHY"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonImagesTapped(_ sender: Any) {
        self.unselectButtons()
        self.buttonImages.setSelected(value: true)
        
        self.collectionView.reloadData()
        
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
    }
    
    @IBAction func buttonVideosTapped(_ sender: Any) {
        self.unselectButtons()
        self.buttonVideos.setSelected(value: true)
        
        self.collectionView.reloadData()
        
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
    }
    
    @IBAction func buttonSocialsTapped(_ sender: Any) {
        self.unselectButtons()
        self.buttonSocials.setSelected(value: true)
        
        self.tableView.reloadData()
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
    }
    
    @IBAction func buttonAudiosTapped(_ sender: Any) {
        self.unselectButtons()
        self.buttonAudios.setSelected(value: true)
        
        self.tableView.reloadData()
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
        
        self.searchBarTopConstraint.constant = 55
    }
    
    func initializeViews() {
        self.unselectButtons()
        self.buttonImages.setSelected(value: true)
        
        self.tableView.isHidden = true
        
        self.photosGallery = self.mediaGallery.filter { $0.type?.lowercased() == "photos" }
        self.videosGallery = self.mediaGallery.filter { $0.type?.lowercased() == "videos" }
        
        if let audios = self.mediaGallery.first?.audios {
            self.audios = audios
        }
    }
    
    func unselectButtons() {
        buttonImages.setSelected(value: false)
        buttonVideos.setSelected(value: false)
        buttonSocials.setSelected(value: false)
        buttonAudios.setSelected(value: false)
        
        searchBarTopConstraint.constant = 0
    }
    
    func setupTableView() {
        self.tableView.register(UINib.init(nibName: CellIdentifiers.SocialTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.SocialTableViewCell)
        self.tableView.register(UINib.init(nibName: CellIdentifiers.AudioTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.AudioTableViewCell)
        self.tableView.tableFooterView = UIView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonAudios.isSelected() {
            return audios.count
        } else if buttonSocials.isSelected() {
            return socials.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if buttonAudios.isSelected() {
            return 70
        } else if buttonSocials.isSelected() {
            return 85
        }
        
        return UITableViewAutomaticDimension
    }
    
    @objc func didSelectRow(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            if buttonAudios.isSelected() {
                self.redirectToVC(storyboardId: StoryboardIds.AudioPlayerViewController, type: .present)
            } else if buttonSocials.isSelected() {
                let social = socials[view.tag]
                
                var urlString: String!
                if let link = social.link {
                    if !link.contains("http://") {
                        urlString = "http://" + link
                    } else {
                        urlString = link
                    }
                }
                
                guard let url = URL(string: urlString) else {
                    return
                }
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if buttonAudios.isSelected() {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.AudioTableViewCell) as? AudioTableViewCell {
                
                let audio = audios[indexPath.row]
                cell.labelTitle.text = audio.title
                
                if let view = cell.contentView.subviews.first {
                    view.layer.cornerRadius = 10
                }
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(didSelectRow(sender:)))
                cell.addGestureRecognizer(tap)
                cell.tag = indexPath.row
                
                return cell
            }
        } else if buttonSocials.isSelected() {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SocialTableViewCell) as? SocialTableViewCell {
                
                let social = socials[indexPath.row]
                if let imageThumb = social.img_thumb {
                    cell.imageViewIcon.kf.setImage(with: URL(string: imageThumb))
                }
                
                if let image = social.image {
                    cell.imageViewIcon.image = image
                }
                
                cell.labelTitle.text = social.title
                
                if let view = cell.contentView.subviews.first {
                    view.layer.cornerRadius = 10
                }
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(didSelectRow(sender:)))
                cell.addGestureRecognizer(tap)
                cell.tag = indexPath.row
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func setupCollectionView() {
        self.collectionView.register(UINib.init(nibName: CellIdentifiers.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.GalleryCollectionViewCell)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if buttonImages.isSelected() {
            return photosGallery.count
        } else if buttonVideos.isSelected() {
            return videosGallery.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let mediaViewController = storyboard?.instantiateViewController(withIdentifier: StoryboardIds.MediaViewController) as? MediaViewController {
            if buttonImages.isSelected() {
                mediaViewController.comingFrom = MediaComingFrom.photos
                mediaViewController.media = photosGallery[indexPath.row]
            } else if buttonVideos.isSelected() {
                mediaViewController.comingFrom = MediaComingFrom.videos
                mediaViewController.media = videosGallery[indexPath.row]
            }
            
            self.present(mediaViewController, animated: true, completion: nil)
        }
    }
    
    let itemSpacing: CGFloat = 5
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width/2)-itemSpacing
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing*2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.GalleryCollectionViewCell, for: indexPath) as? GalleryCollectionViewCell {
            
            if buttonImages.isSelected() {
                let photoGallery = photosGallery[indexPath.row]
                if let imgThumb = photoGallery.img_thumb {
                    cell.imageViewIcon.kf.setImage(with: URL(string: imgThumb))
                }
                
                cell.labelTitle.text = photoGallery.title
            } else if buttonVideos.isSelected() {
                let videoGallery = videosGallery[indexPath.row]
                if let imgThumb = videoGallery.img_thumb {
                    cell.imageViewIcon.kf.setImage(with: URL(string: imgThumb))
                }
                
                cell.labelTitle.text = videoGallery.title
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func dummyData() {
        var media = MediaGallery()
        media.title = "@ Starac"
        media.type = "photos"
        media.img_thumb = "http://www.listenarabic.com/arabic-music/wp-content/uploads/2010/07/Ramy-prime15.jpg"
        media.photos = [
            Photo.init(imgThumb: "http://www.listenarabic.com/arabic-music/wp-content/uploads/2010/07/Ramy-prime15.jpg", gallery: "@ Starac"),
            Photo.init(imgThumb: "https://pbs.twimg.com/profile_images/847824186957602816/hKfSaa0z.jpg", gallery: "@ Starac"),
            Photo.init(imgThumb: "http://4.bp.blogspot.com/_z5zRrw40eZA/TDcDiEA-EDI/AAAAAAAAARA/xmV4c4Xpc10/s1600/rami+010.jpg", gallery: "@ Starac"),
            Photo.init(imgThumb: "http://2.bp.blogspot.com/_z5zRrw40eZA/S86vC7L6oMI/AAAAAAAAAMk/09CPBM5BJ7o/s1600/rami+008.jpg", gallery: "@ Starac")
        ]
        mediaGallery.append(media)
        
        media = MediaGallery()
        media.title = "@ Starac New"
        media.type = "photos"
        media.img_thumb = "http://www.listenarabic.com/arabic-music/wp-content/uploads/2010/07/Ramy-prime13.jpg"
        media.photos = [
            Photo.init(imgThumb: "http://www.listenarabic.com/arabic-music/wp-content/uploads/2010/07/Ramy-prime13.jpg", gallery: "@ Starac"),
            Photo.init(imgThumb: "http://2.bp.blogspot.com/_z5zRrw40eZA/S86vC7L6oMI/AAAAAAAAAMk/09CPBM5BJ7o/s1600/rami+008.jpg", gallery: "@ Starac"),
            Photo.init(imgThumb: "https://i.ytimg.com/vi/uDgIwOOB4zw/hqdefault.jpg", gallery: "@ Starac"),
            Photo.init(imgThumb: "http://img.over-blog.com/600x450/1/50/59/42/chanteurs/chanteur-3/rami-chemalli.jpg", gallery: "@ Starac")
        ]
        mediaGallery.append(media)
        
        media = MediaGallery()
        media.title = "@ Sainte Therese"
        media.type = "photos"
        media.img_thumb = "https://i.ytimg.com/vi/hr8uFv12RQk/hqdefault.jpg"
        media.photos = [
            Photo.init(imgThumb: "https://i.ytimg.com/vi/hr8uFv12RQk/hqdefault.jpg", gallery: "@ Sainte Therese"),
            Photo.init(imgThumb: "https://i.ytimg.com/vi/qZJFxsUW3GA/hqdefault.jpg", gallery: "@ Sainte Therese"),
            Photo.init(imgThumb: "https://i.ytimg.com/vi/lHs2nNofVHQ/hqdefault.jpg", gallery: "@ Sainte Therese"),
            Photo.init(imgThumb: "https://i.ytimg.com/vi/vSV_4MJO4Go/hqdefault.jpg", gallery: "@ Sainte Therese")
        ]
        mediaGallery.append(media)
        
        media = MediaGallery()
        media.title = "@ Sainte Therese New"
        media.type = "photos"
        media.img_thumb = "https://i.ytimg.com/vi/adhn-HX1eRY/hqdefault.jpg"
        media.photos = [
            Photo.init(imgThumb: "https://i.ytimg.com/vi/adhn-HX1eRY/hqdefault.jpg", gallery: "@ Sainte Therese"),
            Photo.init(imgThumb: "https://i.ytimg.com/vi/dEj7Ks3V3ts/hqdefault.jpg", gallery: "@ Sainte Therese"),
            Photo.init(imgThumb: "https://i.ytimg.com/vi/T_vk3QeRbVE/hqdefault.jpg", gallery: "@ Sainte Therese"),
            Photo.init(imgThumb: "https://i.ytimg.com/vi/3G2ANrxDi3s/hqdefault.jpg", gallery: "@ Sainte Therese")
        ]
        mediaGallery.append(media)
        
        media = MediaGallery()
        media.title = "Sainte Therese Concert"
        media.type = "videos"
        media.img_thumb = "https://i.ytimg.com/vi/hr8uFv12RQk/hqdefault.jpg"
        media.videos = [
            Video.init(imgThumb: "https://i.ytimg.com/vi/hr8uFv12RQk/hqdefault.jpg", link: "https://www.youtube.com/watch?v=Zy58QkGUSXQ", duration: "4:30", gallery: "Sainte Therese Concert", title: "في الجلجثة"),
            Video.init(imgThumb: "https://i.ytimg.com/vi/adhn-HX1eRY/hqdefault.jpg", link: "https://www.youtube.com/watch?v=adhn-HX1eRY", duration: "3:34", gallery: "Sainte Therese Concert", title: "أنا بردان"),
            Video.init(imgThumb: "https://i.ytimg.com/vi/WYzwq8BR3wE/hqdefault.jpg", link: "https://www.youtube.com/watch?v=z1vGyiLHpXg", duration: "3:57", gallery: "Sainte Therese Concert", title: "وسط التجارب")
        ]
        mediaGallery.append(media)
        
        media = MediaGallery()
        media.title = "Staracademy Primes"
        media.type = "videos"
        media.img_thumb = ""
        media.videos = [
            Video.init(imgThumb: "https://i.ytimg.com/vi/E88ivMRisGg/hqdefault.jpg", link: "https://www.youtube.com/watch?v=lupnZFOo23w", duration: "3:26", gallery: "Staracademy Primes", title: "shou 3miltilli bil balad"),
            Video.init(imgThumb: "https://i.ytimg.com/vi/777os9S7_YA/mqdefault.jpg", link: "https://www.youtube.com/watch?v=9fSa4qdjcAI", duration: "4:37", gallery: "Staracademy Primes", title: "الهوا طاير"),
            Video.init(imgThumb: "https://i.ytimg.com/vi/-sEXob7wrww/hqdefault.jpg", link: "https://www.youtube.com/watch?v=-sEXob7wrww", duration: "3:16", gallery: "Staracademy Primes", title: "بلغي كل مواعيدي")
        ]
        mediaGallery.append(media)
        
        socials = [
            Social.init(image: #imageLiteral(resourceName: "fb_icon"), title: "Let's Pray With Ramy Chemaly and for Him", link: "https://www.facebook.com/154008231300143/videos/10150282402985637/"),
            Social.init(image: #imageLiteral(resourceName: "fb_icon_gray"), title: "Rami Chemaly الصفحة الرسمية", link: "https://www.facebook.com/Rami.Chemaly.Official.Page/"),
            Social.init(image:#imageLiteral(resourceName: "twitter_icon"), title: "Rami Chemaly", link: "https://twitter.com/ramichemaly?lang=en")
        ]
        
        audios = [
            Audio.init(title: "Audio test 1"),
            Audio.init(title: "Audio test 2"),
            Audio.init(title: "Audio test 3")
        ]
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
