//
//  TransmitViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 04/04/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit
import LFLiveKit


class TransmitViewController: UIViewController, LFLiveSessionDelegate {

    let session = LFLiveSession.init(audioConfiguration: LFLiveAudioConfiguration.default(), videoConfiguration: LFLiveVideoConfiguration.defaultConfiguration(for: .medium2))
    let streamInfo = LFLiveStreamInfo.init()
/*
    var camera = GPUImageVideoCamera.init(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: AVCaptureDevicePosition.front)
    
    var filter = GPUImageFilter.init()
    var filterView = GPUImageView.init(frame: BOUNDS)
*/    
    
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
        
        addressText.text = "192.168.0.100"
        addressText.backgroundColor = UIColor.clear
        addressText.textColor = UIColor.white
        addressText.keyboardType = .URL
        addressText.returnKeyType = .done
        view.addSubview(addressText)
        
        signLabel.textColor = UIColor.white
        signLabel.text = "Not Playing"
        view.addSubview(signLabel)
    }
    
    
    
    
    func startTransmit() {
        let s = "rtmp://\(addressText.text!):1935/rtmplive/room"
        streamInfo.url = s
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
    

//    func isContainArray(array: [Any]) -> Bool {
//        return true
//    }
//    
//    func count(array: [Any]) -> Int {
//        var count = 0
//        
//        for i in array {
//            //判断不是数组
//            count += 1
//            continue
//            //是数组
//            count += count(arr: /*i*/arr)
//        }
//        return count
//    }

    
}
