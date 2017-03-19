//
//  AudioCell.swift
//  LeLive
//
//  Created by Nicholas Lee on 19/03/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

let imageWidth = itemSize.width / 5 * 3

class AudioCell: UICollectionViewCell {
    
    let label = UILabel()
    let imageView = UIImageView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(label)
        self.contentView.addSubview(imageView)

        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
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
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
