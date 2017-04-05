//
//  CameraViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 05/04/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    let camera = GPUImageVideoCamera.init(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: AVCaptureDevicePosition.back)
    
    var filter = GPUImageFilter()
    let filterView = GPUImageView.init(frame: BOUNDS)
    let b1 = UIButton.init(frame: CGRect.init(x: 200, y: 200, width: 50, height: 20))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        camera?.outputImageOrientation = .portrait
        camera?.horizontallyMirrorFrontFacingCamera = true
        
        
        b1.setTitle("Toon", for: .normal)
        b1.addTarget(self, action: #selector(oneButtonDidClick), for: .touchUpInside)
        view.addSubview(b1)
        
        
        
        
        
    }
    
    override func viewWillLayoutSubviews() {
        camera?.addTarget(filter)
        view.addSubview(filterView)
        filter.addTarget(filterView)
        camera?.startCapture()
        view.bringSubview(toFront: b1)
    }
    
    func oneButtonDidClick() {
        filter = GPUImageToonFilter.init()
        view.setNeedsLayout()
    }
    

   
}
