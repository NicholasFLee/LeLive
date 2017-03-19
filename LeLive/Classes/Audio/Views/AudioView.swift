//
//  AudioView.swift
//  LeLive
//
//  Created by Nicholas Lee on 19/03/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit


class AudioView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var audioPlayer = AVPlayer()
    var closure: (_ i: Int) -> Void = {_ in
        
    }
    init() {
        let lo = UICollectionViewFlowLayout()
        lo.itemSize = itemSize
        lo.minimumLineSpacing = 0
        lo.minimumInteritemSpacing = 0
        lo.scrollDirection = .vertical
        super.init(frame: CGRect.zero, collectionViewLayout: lo)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.white
        self.register(AudioCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconURLS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath) as! AudioCell
        
        cell.label.text = titleS[indexPath.row]
        cell.imageView.image = iconURLS[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("click\(indexPath.row)")
        closure(indexPath.row)
    }
    

}
