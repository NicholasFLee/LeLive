//
//  FilterViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 05/04/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    //let camera = GPUImageVideoCamera.init(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: AVCaptureDevicePosition.back)
    
    let movie = GPUImageMovie.init(url: Bundle.main.url(forResource: "Tahiti.mp4", withExtension: nil))
    var filter = GPUImageFilter()
    let filterView = GPUImageView.init(frame: BOUNDS)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        movie?.playAtActualSpeed = true
        
        //movie?.addObserver(self, forKeyPath: "progress", options: .new, context: nil)
        movie?.addTarget(filter)
        view.addSubview(filterView)
        filter.addTarget(filterView)
        movie?.startProcessing()
        
        let b1 = UIButton.init(frame: CGRect.init(x: 0, y: 200, width: 70, height: 20))
        b1.setTitle("Toon", for: .normal)
        b1.addTarget(self, action: #selector(toon), for: .touchUpInside)
        view.addSubview(b1)
        let b2 = UIButton.init(frame: CGRect.init(x: 90, y: 200, width: 70, height: 20))
        b2.setTitle("Pixellate", for: .normal)
        b2.addTarget(self, action: #selector(pixellate), for: .touchUpInside)
        view.addSubview(b2)
        let b3 = UIButton.init(frame: CGRect.init(x: 180, y: 200, width: 70, height: 20))
        b3.setTitle("Stretch", for: .normal)
        b3.addTarget(self, action: #selector(stretchDistortion), for: .touchUpInside)
        view.addSubview(b3)
        
        
        
        
        
    }
    
    
    
    
    func toon() {
        let f = GPUImageToonFilter()
        buttonDidClick(f: f)

    }
    
    func pixellate() {
        let f = GPUImagePixellateFilter()
        buttonDidClick(f: f)
    }
    
    func stretchDistortion() {
        let f = GPUImageStretchDistortionFilter()
        buttonDidClick(f: f)
    }
    
    func emboss() {
        let f = GPUImageEmbossFilter()
        buttonDidClick(f: f)
    }
    
    func buttonDidClick(f: GPUImageFilter) {
        movie?.endProcessing()
        movie?.removeTarget(filter)
        filter = f
        movie?.addTarget(filter)
        filter.addTarget(filterView)
        movie?.startProcessing()

    }

    override func viewWillDisappear(_ animated: Bool) {
        movie?.endProcessing()
    }
   
}
