//
//  TransmitViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 04/04/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit
import LFLiveKit

var TRANSMITSTRING = " "

class TransmitViewController: UIViewController, LFLiveSessionDelegate {

    let session = LFLiveSession.init(audioConfiguration: LFLiveAudioConfiguration.default(), videoConfiguration: LFLiveVideoConfiguration.defaultConfiguration(for: .medium2))
    let streamInfo = LFLiveStreamInfo.init()
    let addressText = UITextField.init(frame: CGRect.init(x: 30, y: 30, width: 300, height: 20))
    let signLabel = UILabel.init(frame: CGRect.init(x: 30, y: 60, width: 100, height: 20))

    override func viewDidLoad() {
        super.viewDidLoad()
        session?.preView = self.view
        session?.running = true
        session?.delegate = self
        session?.captureDevicePosition = .back
        
        let b = UIButton.init(frame: CGRect.init(x: 305, y: 600, width: 70, height: 20))
        b.setTitleColor(UIColor.gray, for: .normal)
        b.setTitle("Close", for: .normal)
        view.addSubview(b)
        b.addTarget(self, action: #selector(closeButtonDidClick), for: .touchUpInside)
        
        let change = UIButton.init(frame: CGRect.init(x: 215, y: 600, width: 70, height: 20))
        change.setTitleColor(UIColor.gray, for: .normal)
        change.setTitle("change", for: .normal)
        view.addSubview(change)
        change.addTarget(self, action: #selector(changeFrontAndBackCamera), for: .touchUpInside)
        
        let start = UIButton.init(frame: CGRect.init(x: 115, y: 600, width: 70, height: 20))
        start.setTitleColor(UIColor.gray, for: .normal)
        start.setTitle("start", for: .normal)
        view.addSubview(start)
        start.addTarget(self, action: #selector(startTransmit), for: .touchUpInside)
        
        addressText.text = "rtmp://192.168.0.108:1935/rtmplive/room"
        addressText.backgroundColor = UIColor.clear
        addressText.textColor = UIColor.white
        addressText.keyboardType = .URL
        addressText.returnKeyType = .done
        view.addSubview(addressText)
        
        signLabel.textColor = UIColor.white
        signLabel.text = "Not Playing"
        
    }
    
    func startTransmit() {
        TRANSMITSTRING = addressText.text!
        streamInfo.url = addressText.text
        session?.startLive(streamInfo)
        signLabel.text = "Playing"
    }
    
    func changeFrontAndBackCamera() {
        if session?.captureDevicePosition == .back {
            session?.captureDevicePosition = .front
        } else {
            session?.captureDevicePosition = .back
        }
    }
    
    func closeButtonDidClick() {
        session?.stopLive()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addressText.resignFirstResponder()
    }

    
}
