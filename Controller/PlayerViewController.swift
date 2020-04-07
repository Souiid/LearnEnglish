//
//  PlayerViewController.swift
//  Learn English
//
//  Created by Idriss Souissi on 22/01/2020.
//  Copyright © 2020 Idriss Souissi. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: UIViewController {
    
    //MARK: - Propreties and Outlets
    
    @IBOutlet weak var frenchVideoImageView: UIImageView!
    @IBOutlet weak var englishVideoImageView: UIImageView!
    
    var nameOfVideo = String()
    
    //MARK: - Methods
        
    override func viewDidLoad() {
        super.viewDidLoad()
        frenchVideoImageView.image = UIImage(named: nameOfVideo)
        englishVideoImageView.image = UIImage(named: nameOfVideo)
    }
    
    //Present a video with AVPlayerViewController
    private func presentVideo(nameOfRessource: String) {
        guard let path =  Bundle.main.path(forResource: nameOfRessource, ofType: "mp4") else {return}
        let videoURL = URL(fileURLWithPath: path)
        let player = AVPlayer(url: videoURL)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        self.present(playerVC, animated: true) {
            playerVC.player?.play()
        }
    }
    
    //Present the video with french subtitles
    @IBAction func playFrenchVideo(_ sender: Any) {
        presentVideo(nameOfRessource: nameOfVideo)
    }
    
    //Present the video with english subtitles
    @IBAction func playEnglishVideo(_ sender: Any) {
        presentVideo(nameOfRessource: nameOfVideo + "EN")
    }
}
