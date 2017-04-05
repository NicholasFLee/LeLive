//
//  ManualViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 04/04/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {

    let addressText = UITextField.init(frame: CGRect.init(x: 30, y: 30, width: 300, height: 20))
    var player = IJKFFMoviePlayerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        addressText.text = "192.168.0.108"
        addressText.backgroundColor = UIColor.clear
        addressText.textColor = UIColor.white
        addressText.keyboardType = .URL
        addressText.returnKeyType = .done
        view.addSubview(addressText)
        
        
        let ready = UIButton.init(frame: CGRect.init(x: 115, y: 600, width: 70, height: 20))
        ready.setTitle("start", for: .normal)
        view.addSubview(ready)
        ready.addTarget(self, action: #selector(readyToCatch), for: .touchUpInside)
        
        
    }
    //rtmp://192.168.0.100:1935/rtmplive/room
    func readyToCatch() {
        let s = "rtmp://\(addressText.text!):1935/rtmplive/room"
        player = IJKFFMoviePlayerController(contentURLString: s, with: nil)
        player.view.frame = BOUNDS
        self.view.insertSubview(player.view, at: 0)
        player.prepareToPlay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addressText.resignFirstResponder()
    }
    
}
