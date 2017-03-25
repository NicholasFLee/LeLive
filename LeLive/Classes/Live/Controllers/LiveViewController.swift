//
//  LiveViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 2017/2/28.
//  Copyright © 2017年 Nicholas Lee. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {
    
    var obj = LiveObj()
    var player = IJKFFMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgi = UIImageView.init(frame: UIScreen.main.bounds)
        bgi.kf.setImage(with: URL.init(string:obj.creator.portrait))
        bgi.contentMode = .scaleAspectFill
        bgi.alpha = 0.7
        view.addSubview(bgi)
        player = IJKFFMoviePlayerController(contentURLString: obj.stream_addr, with: nil)
        player.prepareToPlay()
        player.view.frame = UIScreen.main.bounds
        self.view.insertSubview(player.view, at: 1)
        let b = UIButton.init(frame: CGRect.init(x: 305, y: 600, width: 50, height: 20))
        b.setTitle("Close", for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(b)
        b.addTarget(self, action: #selector(closeButtonDidClick), for: .touchUpInside)
    }
    
    func closeButtonDidClick() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.pause()
        player.shutdown()
        self.navigationController?.setNavigationBarHidden(false, animated:false)
        self.tabBarController?.tabBar.isHidden = false
    }

    
}
