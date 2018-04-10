//
//  AudioPlayerViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/11/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Alamofire

extension UIImageView {
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

class AudioPlayerViewController: BaseViewController, AVAudioPlayerDelegate {
    
    let playImage = UIImage(named: "play")
    let pauseImage = UIImage(named: "pause")
    
    var audios: [Audio] = [Audio]()
    
    var audioPlayer:AVAudioPlayer! = nil
    var isTableViewOnscreen = false
    var totalLengthOfAudio = ""
    var shuffleArray = [Int]()
    var currentAudioIndex = 0
    var currentAudioPath:URL!
    var shuffleState = false
    var repeatState = false
    var effectToggle = true
    var finalImage:UIImage!
    var audioLength = 0.0
    var currentAudio = ""
    var toggle = true
    var timer:Timer!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var lineView : UIView!
    @IBOutlet weak var albumArtworkImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet var songNameLabel : UILabel!
    @IBOutlet var progressTimerLabel : UILabel!
    @IBOutlet var playerProgressSlider : UISlider!
    @IBOutlet var totalLengthOfAudioLabel : UILabel!
    @IBOutlet var previousButton : UIButton!
    @IBOutlet var playButton : UIButton!
    @IBOutlet var nextButton : UIButton!
    @IBOutlet var blurImageView : UIImageView!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var progressView: CircleProgressView!
    @IBOutlet weak var progressCenterImage: UIImageView!
    
    // This shows media info on lock screen - used currently and perform controls
    func showMediaInfo(){
        let audio = audios[currentAudioIndex]
        let artistName = audio.artist_name
        let songName = audio.song_name
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyArtist : artistName ?? "",  MPMediaItemPropertyTitle : songName ?? ""]
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        if event!.type == UIEventType.remoteControl{
            switch event!.subtype{
            case UIEventSubtype.remoteControlPlay:
                play(self)
            case UIEventSubtype.remoteControlPause:
                play(self)
            case UIEventSubtype.remoteControlNextTrack:
                next(self)
            case UIEventSubtype.remoteControlPreviousTrack:
                previous(self)
            default:
                break
            }
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override var prefersStatusBarHidden : Bool {
        if isTableViewOnscreen {
            return true
        } else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this sets last listened trach number as current
        self.retrieveSavedTrackNumber()
        
        self.prepareAudio()
        self.updateLabels()
        self.setRepeatAndShuffle()
        self.removeAudioObjectsFromUserDefaults()
        self.retrievePlayerProgressSliderValue()
        self.setupProgressView()
        
        //LockScreen Media control registry
        if UIApplication.shared.responds(to: #selector(UIApplication.beginReceivingRemoteControlEvents)){
            UIApplication.shared.beginReceivingRemoteControlEvents()
            UIApplication.shared.beginBackgroundTask(expirationHandler: { () -> Void in
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        backgroundImageView.addBlur()
    }
    
    func setupProgressView() {
        progressView.progress = 0
        progressView.alpha = 0
        
        progressCenterImage.layer.cornerRadius = progressCenterImage.frame.width/2
    }
    
    func setRepeatAndShuffle(){
        shuffleState = UserDefaults.standard.bool(forKey: "shuffleState")
        repeatState = UserDefaults.standard.bool(forKey: "repeatState")
        if shuffleState == true {
            shuffleButton.isSelected = true
        } else {
            shuffleButton.isSelected = false
        }
        
        if repeatState == true {
            repeatButton.isSelected = true
        }else{
            repeatButton.isSelected = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
        albumArtworkImageView.setRounded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.stopTimer()
        self.stopAudioplayer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // MARK:- AVAudioPlayer Delegate's Callback method
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag == true {
            if shuffleState == false && repeatState == false {
                // do nothing
                playButton.setImage( UIImage(named: "play"), for: UIControlState())
                return
                
            } else if shuffleState == false && repeatState == true {
                //repeat same song
                prepareAudio()
                playAudio()
            } else if shuffleState == true && repeatState == false {
                //shuffle songs but do not repeat at the end
                //Shuffle Logic : Create an array and put current song into the array then when next song come randomly choose song from available song and check against the array it is in the array try until you find one if the array and number of songs are same then stop playing as all songs are already played.
                shuffleArray.append(currentAudioIndex)
                if shuffleArray.count >= audios.count {
                    playButton.setImage( UIImage(named: "play"), for: UIControlState())
                    return
                }

                var randomIndex = 0
                var newIndex = false
                while newIndex == false {
                    randomIndex =  Int(arc4random_uniform(UInt32(audios.count)))
                    if shuffleArray.contains(randomIndex) {
                        newIndex = false
                    }else{
                        newIndex = true
                    }
                }
                currentAudioIndex = randomIndex
                prepareAudio()
                playAudio()
            } else if shuffleState == true && repeatState == true {
                //shuffle song endlessly
                shuffleArray.append(currentAudioIndex)
                if shuffleArray.count >= audios.count {
                    shuffleArray.removeAll()
                }
                
                var randomIndex = 0
                var newIndex = false
                while newIndex == false {
                    randomIndex =  Int(arc4random_uniform(UInt32(audios.count)))
                    if shuffleArray.contains(randomIndex) {
                        newIndex = false
                    }else{
                        newIndex = true
                    }
                }
                currentAudioIndex = randomIndex
                prepareAudio()
                playAudio()
            }
        }
    }
    
    //Sets audio file URL
    func setCurrentAudioPath(){
        let audio = audios[currentAudioIndex]
        if let songName = audio.song_name {
            currentAudio = songName
        }
        currentAudioPath = nil
        if let audioPath = audio.audio_path {
            currentAudioPath = audioPath
        }
    }
    
    func saveCurrentTrackNumber(){
        UserDefaults.standard.set(currentAudioIndex, forKey:"currentAudioIndex")
        UserDefaults.standard.synchronize()
    }
    
    func retrieveSavedTrackNumber(){
        if let currentAudioIndex_ = UserDefaults.standard.object(forKey: "currentAudioIndex") as? Int{
            currentAudioIndex = currentAudioIndex_
        }
    }
    
    // Prepare audio for playing
    func prepareAudio(){
        setCurrentAudioPath()
        do {
            //keep alive audio at background
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ { }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {}
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        progressTimerLabel.text = "00:00"
        playerProgressSlider.value = 0.0
        showTotalSongLength()
        updateLabels()
        
        if let audioPath = currentAudioPath {
//            if let player = audioPlayer {
//                if player.isPlaying && player.currentTime > 0 {
//                    player.play()
//                    return
//                }
//            }
            audioPlayer = try? AVAudioPlayer(contentsOf: audioPath)
            if audioPlayer == nil {
                playButton.setImage(playImage, for: UIControlState())
                audios[currentAudioIndex].audio_path = nil
                return
            }
            
            audioPlayer.delegate = self
            audioLength = audioPlayer.duration
            playerProgressSlider.maximumValue = CFloat(audioPlayer.duration)
            playerProgressSlider.minimumValue = 0.0
            playerProgressSlider.value = 0.0
            audioPlayer.prepareToPlay()
        }
    }
    
    //MARK:- Player Controls Methods
    func playAudio(){
        if audioPlayer != nil {
            audioPlayer.play()
            startTimer()
//            updateLabels()
            saveCurrentTrackNumber()
            showMediaInfo()
        }
    }
    
    func playNextAudio(){
        currentAudioIndex += 1
        if currentAudioIndex>audios.count-1{
            currentAudioIndex = 0
        }
        
        if audioPlayer != nil && audioPlayer.isPlaying{
            stopAudioplayer()
            play(playButton)
            return
//            prepareAudio()
//            playAudio()
        }else{
            prepareAudio()
        }
    }
    
    func playPreviousAudio(){
        currentAudioIndex -= 1
        if currentAudioIndex < 0 {
            currentAudioIndex = audios.count-1
        }
        if audioPlayer != nil && audioPlayer.isPlaying{
            stopAudioplayer()
            play(playButton)
            return
//            prepareAudio()
//            playAudio()
        }else{
            prepareAudio()
        }
        
    }
    
    func stopAudioplayer(){
        if audioPlayer != nil {
            audioPlayer.stop()
        }
    }
    
    func pauseAudioPlayer(){
        if audioPlayer != nil {
            audioPlayer.pause()
        }
    }
    
    //MARK:-
    func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AudioPlayerViewController.update(_:)), userInfo: nil,repeats: true)
            timer.fire()
        }
    }
    
    func stopTimer(){
        if timer != nil {
            timer.invalidate()
        }
    }
    
    @objc func update(_ timer: Timer){
        if audioPlayer == nil || !audioPlayer.isPlaying {
            return
        }
        let time = calculateTimeFromNSTimeInterval(audioPlayer.currentTime)
        progressTimerLabel.text  = "\(time.minute):\(time.second)"
        playerProgressSlider.value = CFloat(audioPlayer.currentTime)
        
        UserDefaults.standard.set(playerProgressSlider.value , forKey: "playerProgressSliderValue")
    }
    
    func retrievePlayerProgressSliderValue(){
        let playerProgressSliderValue = UserDefaults.standard.float(forKey: "playerProgressSliderValue")
        if playerProgressSliderValue != 0 {
            playerProgressSlider.value = playerProgressSliderValue
            if audioPlayer != nil {
                audioPlayer.currentTime = TimeInterval(playerProgressSliderValue)
                let time = calculateTimeFromNSTimeInterval(audioPlayer.currentTime)
                progressTimerLabel.text  = "\(time.minute):\(time.second)"
                playerProgressSlider.value = CFloat(audioPlayer.currentTime)
            }
        }else{
            playerProgressSlider.value = 0.0
            progressTimerLabel.text = "00:00:00"
            if audioPlayer != nil {
                audioPlayer.currentTime = 0.0
            }
        }
    }
    
    //This returns song length
    func calculateTimeFromNSTimeInterval(_ duration:TimeInterval) ->(minute:String, second:String){
        // let hour_   = abs(Int(duration)/3600)
        let minute_ = abs(Int((duration/60).truncatingRemainder(dividingBy: 60)))
        let second_ = abs(Int(duration.truncatingRemainder(dividingBy: 60)))
        
        // var hour = hour_ > 9 ? "\(hour_)" : "0\(hour_)"
        let minute = minute_ > 9 ? "\(minute_)" : "0\(minute_)"
        let second = second_ > 9 ? "\(second_)" : "0\(second_)"
        return (minute,second)
    }
    
    func showTotalSongLength(){
        calculateSongLength()
        totalLengthOfAudioLabel.text = totalLengthOfAudio
    }
    
    func calculateSongLength(){
        let time = calculateTimeFromNSTimeInterval(audioLength)
        totalLengthOfAudio = "\(time.minute):\(time.second)"
    }
    
    func updateLabels(){
        updateArtistNameLabel()
        updateAlbumNameLabel()
        updateSongNameLabel()
        updateSongDurationLabel()
        updateAlbumArtwork()
    }
    
    func updateArtistNameLabel(){
        if let artistName = audios[currentAudioIndex].artist_name {
            artistNameLabel.text = artistName
        }
    }
    
    func updateAlbumNameLabel(){
        if let albumName = audios[currentAudioIndex].album_name {
            albumNameLabel.text = albumName
        }
    }
    
    func updateSongNameLabel(){
        if let songName = audios[currentAudioIndex].song_name {
            songNameLabel.text = songName
        }
    }
    
    func updateSongDurationLabel(){
        if let duration = audios[currentAudioIndex].duration {
            totalLengthOfAudioLabel.text = duration
        }
    }
    
    func updateAlbumArtwork(){
        if let artworkName = audios[currentAudioIndex].album_artwork {
            let albumArtwork = artworkName.isEmpty ? defaultBackground : artworkName
            albumArtworkImageView.kf.setImage(with: URL(string: Services.getMediaUrl() + albumArtwork!))
            backgroundImageView.kf.setImage(with: URL(string: Services.getMediaUrl() + albumArtwork!))
        }
    }
    
    @IBAction func play(_ sender : AnyObject) {
        if shuffleState == true {
            shuffleArray.removeAll()
        }
    
        if audioPlayer != nil && audioPlayer.isPlaying{
            pauseAudioPlayer()
            playButton.setImage(playImage, for: UIControlState())
        }else{
            let audio = audios[currentAudioIndex]
            if let audioPath = audio.audio_path {
                self.currentAudioPath = audioPath
                self.prepareAudio()
                self.playAudio()
                
                DispatchQueue.main.async {
                    self.playButton.setImage(self.pauseImage, for: UIControlState())
                }
            } else {
                if let urlString = audio.audio_url{ //?.safeAddingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
                    if let url = URL(string: Services.getMediaUrl() + urlString) {
                        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
                        
                        UIView.animate(withDuration: 0.5, animations: {
                            self.progressView.alpha = 1
                            self.nextButton.isEnabled(enable: false)
                            self.previousButton.isEnabled(enable: false)
                        })
                        
                        if let image = albumArtworkImageView.image {
                            progressCenterImage.image = image
                        }
                        
                        Alamofire.download(
                            url,
                            method: .get,
                            parameters: nil,
                            encoding: JSONEncoding.default,
                            headers: nil,
                            to: destination).downloadProgress(closure: { (progress) in
                                let totalUnit = progress.totalUnitCount
                                let completedUnit = progress.completedUnitCount
                                self.progressView.progress = Double(completedUnit)/Double(totalUnit)
                            }).response(completionHandler: { (DefaultDownloadResponse) in
                                DispatchQueue.main.async {
                                    self.progressCenterImage.image = nil
                                    UIView.animate(withDuration: 0.5, animations: {
                                        self.progressView.alpha = 0
                                        self.nextButton.isEnabled(enable: true)
                                        self.previousButton.isEnabled(enable: true)
                                    })
                                    
                                    if let audioPath = DefaultDownloadResponse.destinationURL {
                                        self.currentAudioPath = audioPath
                                        self.audios[self.currentAudioIndex].audio_path = self.currentAudioPath
                                        self.playButton.setImage(self.pauseImage, for: UIControlState())

                                        if currentVC is AudioPlayerViewController {
                                            self.prepareAudio()
                                            self.playAudio()
                                        }
                                    }
                                }
                            })
                    }
                }
            }
        }
    }
    
    @IBAction func next(_ sender : AnyObject) {
        playNextAudio()
    }
    
    @IBAction func previous(_ sender : AnyObject) {
        playPreviousAudio()
    }
    
    @IBAction func changeAudioLocationSlider(_ sender : UISlider) {
        if audioPlayer != nil {
            audioPlayer.currentTime = TimeInterval(sender.value)
        }
    }
    
    @IBAction func userTapped(_ sender : UITapGestureRecognizer) {
        play(self)
    }
    
    @IBAction func userSwipeLeft(_ sender : UISwipeGestureRecognizer) {
        next(self)
    }
    
    @IBAction func userSwipeRight(_ sender : UISwipeGestureRecognizer) {
        previous(self)
    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        shuffleArray.removeAll()
        if sender.isSelected == true {
            sender.isSelected = false
            shuffleState = false
            UserDefaults.standard.set(false, forKey: "shuffleState")
        } else {
            sender.isSelected = true
            shuffleState = true
            UserDefaults.standard.set(true, forKey: "shuffleState")
        }
    }
    
    @IBAction func repeatButtonTapped(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            repeatState = false
            UserDefaults.standard.set(false, forKey: "repeatState")
        } else {
            sender.isSelected = true
            repeatState = true
            UserDefaults.standard.set(true, forKey: "repeatState")
        }
    }
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        self.dismissVC()
    }
    
//    func getSaveFileUrl(fileName: String) -> URL {
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let nameUrl = URL(string: fileName)
//        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
//        NSLog(fileURL.absoluteString)
//        return fileURL;
//    }
    
}
