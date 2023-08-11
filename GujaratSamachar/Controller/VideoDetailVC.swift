//
//  VideoDetailVC.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 23/06/23.
//

import UIKit
import AVFoundation

class VideoDetailVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var playerview: VideoPlayerView!
    @IBOutlet weak var imgPlayerViewThumb: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    // MARK: - Global Variable
    var videoURL : String!
    var videoData : Datum!
    
    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControl()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopVideoOnDisappear()
    }
    
    // MARK: - Configure Control
    func configureControl() {
        imgPlayerViewThumb.setRadiusToView(cornerRadius: 20)
        playerview.setRadiusToView(cornerRadius: 20)
        playerview.setBorderToView(borderColor: UIColor.clear, borderWidth: 10)
        
        self.lblTitle.text = videoData.metaTitle
        self.lblDesc.text = videoData.metaDescriptions
        self.play()
    }
}

extension VideoDetailVC {
    // MARK: - Play
    func play() {
        let url : URL = URL(string: videoURL)!
        playerview.replay()
        playerview.play(for: url)
        
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

            case .playing:
                
                print("Playing")
            }
            
            self.playerview.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 60), using: { [weak self] _ in
                guard let self = self else { return }
            })
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(itemDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: self.playerview.player?.currentItem)
    }
    
    //Item(Player) Did Finish Playing
    @objc func itemDidFinishPlaying(_ notification: Notification) {
        removeObser()
    }
    
    //Remove Observer
    func removeObser() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: self.playerview.player?.currentItem)
    }
    
    //Stop Video OnDisappear Observer
    func stopVideoOnDisappear(){
        if playerview != nil {
            
            if playerview.state == .playing {
                playerview.pause(reason: .userInteraction)
            }
        }
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: self.playerview.player?.currentItem)
    }
}
