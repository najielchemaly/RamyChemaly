//
//  YoutubePlayerViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/11/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YoutubePlayerViewController: BaseViewController, YTPlayerViewDelegate {

    @IBOutlet weak var youtubePlayer: YTPlayerView!
    
    var videoId: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupYoutubePlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.toolbarView.labelTitle.text = ""
    }

    func setupYoutubePlayer() {
        self.youtubePlayer.delegate = self
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        let playerVars = [
            "autoplay" : 0,
            "controls" : 1,
            "rel" : 0,
            "fs" : 0
        ]
        self.youtubePlayer.load(withVideoId: videoId, playerVars: playerVars)
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .buffering:
            break
        case .playing:
            break
        case .ended:
            break
        case .paused:
            break
        default:
            break
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
