//
//  AudioViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 19/03/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {

    var audioPlayer = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UK Radios"
        let audioView = AudioView.init()
        audioView.frame = BOUNDS
        self.view.addSubview(audioView)
        
        audioPlayer = audioView.audioPlayer
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "stop"), style: .plain, target: self, action: nil)
        
        audioView.closure = { i in
            let url = URL.init(string: StreamURLS[i])!
            print(url)
            self.audioPlayer = AVPlayer.init(url: url)
            self.audioPlayer.play()
        }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.audioPlayer.pause()
        print("dis")
    }

  
    



}



