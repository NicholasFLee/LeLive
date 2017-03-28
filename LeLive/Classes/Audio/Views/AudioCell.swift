//
//  AudioCell.swift
//  LeLive
//
//  Created by Nicholas Lee on 19/03/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

let imageWidth = itemSize.width / 5 * 3
let iview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: itemSize.width, height: itemSize.width))

class AudioCell: UICollectionViewCell {
    
    let label = UILabel()
    let imageView = UIImageView()
    var itemAnimationClosure: () -> Void = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(label)
        self.contentView.addSubview(imageView)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(imageWidth)
            make.center.equalToSuperview()
        }
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(itemSize.width / 8 * 1)
            make.height.equalTo(itemSize.width / 10 * 1)
            make.width.equalToSuperview()
        }
        itemAnimationClosure = {
            self.itemAnimation()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemAnimation() {
        iview.backgroundColor = #colorLiteral(red: 0.6709846616, green: 0.9441583855, blue: 0.9764705896, alpha: 1)
        iview.layer.cornerRadius = 60
        let animationScale = CABasicAnimation.init(keyPath: "transform.scale")
        animationScale.fromValue = NSNumber.init(value: 0.6)
        animationScale.toValue = NSNumber.init(value: 1.3)
        let animationCapacity = CABasicAnimation.init(keyPath: "opacity")
        animationCapacity.fromValue = NSNumber.init(value: 1)
        animationCapacity.toValue = NSNumber.init(value: 0)
        let animationGroup = CAAnimationGroup.init()
        animationGroup.animations = [animationScale, animationCapacity]
        animationGroup.duration = 2
        animationGroup.repeatCount = MAXFLOAT
        iview.layer.add(animationGroup, forKey: nil)
        self.contentView.addSubview(iview)
        self.contentView.bringSubview(toFront: imageView)
        self.contentView.bringSubview(toFront: label)
    }
    
    
    
    
    
}
