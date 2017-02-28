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
        player = IJKFFMoviePlayerController(contentURLString: obj.stream_addr, with: nil)
        player.prepareToPlay()
        player.view.frame = UIScreen.main.bounds
        self.view.insertSubview(player.view, at: 0)
        
        let b = UIButton.init(frame: CGRect.init(x: 305, y: 627, width: 50, height: 20))
        b.setTitle("Close", for: .normal)
        self.view.addSubview(b)
        b.addTarget(self, action: #selector(closeButtonDidClick), for: .touchUpInside)
    }
    
    func closeButtonDidClick() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.pause()
        player.shutdown()
    }

    
}
