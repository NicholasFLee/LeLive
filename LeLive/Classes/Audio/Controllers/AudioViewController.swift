//
//  AudioViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 19/03/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {
    var loadingIv = UIImageView()
    var audioPlayer = AVPlayer() {
        willSet {
            print("status info:\(audioPlayer.observationInfo)")
            if (audioPlayer.observationInfo != nil) {
                print("status info:\(audioPlayer.observationInfo!)")
                audioPlayer.removeObserver(self, forKeyPath: "status")
                audioPlayer.removeObserver(self, forKeyPath: "timeControlStatus")
            }
            newValue.addObserver(self, forKeyPath: "status", options: .new, context: nil)
            newValue.addObserver(self, forKeyPath: "timeControlStatus", options: .new, context: nil)
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UK Radios"
        let audioView = AudioView.init()
        audioView.frame = BOUNDS
        self.view.addSubview(audioView)
    
        audioPlayer = audioView.audioPlayer
        audioView.closure = { i in
            
            
            
            let url = URL.init(string: StreamURLS[i])!
            self.audioPlayer = AVPlayer.init(url: url)
            self.audioPlayer.play()
            self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "stop")
///
            self.loadingIv = UIImageView.init(image: #imageLiteral(resourceName: "loading"))
            self.loadingIv.layer.add(self.loadingAnimation(), forKey: nil)
            self.loadingIv.frame = CGRect.init(x: 19.5, y: 4.5, width: 33, height: 33)
            self.navigationController?.navigationBar.addSubview(self.loadingIv)

            if self.audioPlayer.status == .readyToPlay {
//                self.loadingIv.removeFromSuperview()
            }
            
        }
        
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "play"), style: .plain, target: self, action: #selector(leftBarButtonDidClick))
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 20)
        print("statusnoc\(self.audioPlayer.status.rawValue)")
        
        
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.7036997676, green: 0.9950520396, blue: 0.9879503846, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "status" {
            switch self.audioPlayer.status.rawValue {
            case 0:
//                loadingIv.removeFromSuperview()
                
                

                print("status unknow")
                
                
            case 1:
                
//                loadingIv.removeFromSuperview()
                print("status readyToPlay")
                
            case 2:
                
                print("status failed")
                
            default:
                break
            }
        }
        
        if keyPath == "timeControlStatus" {
            
            switch self.audioPlayer.timeControlStatus {
            case .paused:
                
                print("cs paused ")
            case .playing:
                print("cs playing ")
                self.loadingIv.removeFromSuperview()
                
            case .waitingToPlayAtSpecifiedRate:
                print("cs waitingToPlayAtSpecifiedRate ")
                
            default:
                break
            }
            
            
        }
        
    }
    
    func leftBarButtonDidClick() {
        
        if audioPlayer.timeControlStatus.hashValue == 0 {
            
            if self.audioPlayer.status.rawValue == 0 {
                let url = URL.init(string: StreamURLS[0])!
                self.audioPlayer = AVPlayer.init(url: url)
            }
            self.audioPlayer.play()
            self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "stop")
            // loading animation
            
            
            self.loadingIv = UIImageView.init(image: #imageLiteral(resourceName: "loading"))
            self.loadingIv.layer.add(loadingAnimation(), forKey: nil)
            self.loadingIv.frame = CGRect.init(x: 19.5, y: 4.5, width: 33, height: 33)
            self.navigationController?.navigationBar.addSubview(loadingIv)
            
            
            
        } else if audioPlayer.timeControlStatus.hashValue == 2 || audioPlayer.timeControlStatus.hashValue == 1{
            self.audioPlayer.pause()
            self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "play")
//            self.loadingIv.removeFromSuperview()
        }
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.audioPlayer.pause()
        
        
    }
    
    func loadingAnimation() -> CABasicAnimation {
        let basic = CABasicAnimation.init(keyPath: "transform.rotation")
        basic.fromValue = NSNumber.init(value: 0)
        basic.toValue = NSNumber.init(value: M_PI * 2)
        basic.duration = 2
        basic.repeatCount = 10
        return basic
    }

  
    



}



