//
//  BackCenterViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 03/04/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

var backSelectClosure: (_ i: Int) -> Void = {_ in }

class BackCenterViewController: UIViewController {

    static let centerVC = BackCenterViewController()
    let videoNVC = UINavigationController.init(rootViewController: VideoViewController())
    let audioNVC = UINavigationController.init(rootViewController: AudioViewController())
    let manualVC = ManualViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = BOUNDS
        self.view.backgroundColor = UIColor.white
        self.addChildViewController(videoNVC)
        self.addChildViewController(audioNVC)
        self.addChildViewController(manualVC)
        self.view.addSubview(videoNVC.view)
        
        
        backSelectClosure = { i in
            if i == 0 {
                self.view.addSubview(self.videoNVC.view)
            } else if i == 1 {
                self.view.addSubview(self.audioNVC.view)
            } else if i == 2 {
                self.view.addSubview(self.manualVC.view)
            }
        }
        
        
        
    }

    
    
    


}
