//
//  VideoDetailVC.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 23/06/23.
//

import UIKit
import AVFoundation

class VideoDetailVC: UIViewController {
    @IBOutlet weak var playerview: VideoPlayerView!
    @IBOutlet weak var imgPlayerViewThumb: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    var videoURL : String!
    var videoData : Datum!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPlayerViewThumb.setRadiusToView(cornerRadius: 20)
        playerview.setRadiusToView(cornerRadius: 20)
        playerview.setBorderToView(borderColor: UIColor.clear, borderWidth: 10)

        
        self.lblTitle.text = videoData.metaTitle
        self.lblDesc.text = videoData.metaDescriptions
        self.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopVideoOnDisappear()
    }

}

extension VideoDetailVC {
    func play() {
       
//        var isHide = false
//        self.isPauser = false
//
//        self.imgPlay.isHidden = true
        
        //"videoUrl" : "video\/video_1687248313919.mp4",
        
        let url : URL = URL(string: videoURL)!
        let asset = AVAsset(url: url)
//        let duration = asset.duration
//        let durationTime = CMTimeGetSeconds(duration)

        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
//        SVProgressHUD.show()
//        SVProgressHUD.setBackgroundColor(UIColor.clear)
//        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        playerview.replay()
        playerview.play(for: url)
        
//        if Globals.getMute() == true {
//
//            btnMenu.setImage(UIImage(named: "mutevideo"), for: .normal)
//            playerview.isMuted = true
//
//        } else {
//
//            btnMenu.setImage(UIImage(named: "unmutevideo"), for: .normal)
//            playerview.isMuted = false
//
//        }
        playerview.isMuted = false
        playerview.isAutoReplay = false
        playerview.contentMode = .scaleToFill
        playerview.stateDidChanged = { state in
            switch state {
            case .none:
                print("none")
            case .error(let error):
                print("error - \(error.localizedDescription)")
            case .loading:
                print("loading")
            
            case .paused(let playing, let buffering):
                print("paused - progress \(Int(playing * 100))% buffering \(Int(buffering * 100))%")
                
//                if self.isPauser {
//
//                } else {
           
//                    SVProgressHUD.show()
//                }

            case .playing:
                
                print("Playing")
                
//                if self.isp {
//
//                    self.isp = false
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        let title = self.stitle.prefix(100)
//
//                        Analytics.logEvent("tvc_video_interaction",parameters: [
//                            "news_category":self.slug,
//                            "title":title.replacingOccurrences(of: "-", with: "_"),
//                            "published_date":self.time,
//                            "duration":"\(self.duration)",
//                            "screen_name":"video_screen",
//                            "event_scope_client_id":Analytics.appInstanceID()!,
//                            "user_scope_client_id":Analytics.appInstanceID()!,
//                            "action_performed": "play",
//                            "previous_screen_name": appDelegate.prev_screen,
//                            "author":"na",
//                        ])
//
//
//                        let abc = [
//                            "news_category":self.slug,
//                            "title":title.replacingOccurrences(of: "-", with: "_"),
//                            "published_date":self.time,
//                            "duration":"\(self.duration)",
//                            "screen_name":"video_screen",
//                            "event_scope_client_id":Analytics.appInstanceID()!,
//                            "user_scope_client_id":Analytics.appInstanceID()!,
//                            "action_performed": "play",
//                            "previous_screen_name": "na",
//                            "author":"na",
//                        ] as [String : Any]
//
//                        print(abc)
//                    }
//                }
            
//                self.playerview.isHidden = false
//
//                SVProgressHUD.dismiss()

            }
            
            self.playerview.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 60), using: { [weak self] _ in
                guard let self = self else { return }
                
//                DispatchQueue.main.async {
//                    SVProgressHUD.dismiss()
//                }
                
//                self.isPauser = false
//                if isHide == false {
//                    isHide = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        self.imgVideo.isHidden = true
//                    }
//                }
            })
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(itemDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: self.playerview.player?.currentItem)
    }
    
    @objc func itemDidFinishPlaying(_ notification: Notification) {
    
        removeObser()
//        delegate?.getYelpData(index: self.sindex)
        
    }
    
    func removeObser() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: self.playerview.player?.currentItem)
    }
    
    func stopVideoOnDisappear(){
        if playerview != nil {
            
            if playerview.state == .playing {
                playerview.pause(reason: .userInteraction)
            }
        }
        
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: self.playerview.player?.currentItem)
    }

}
