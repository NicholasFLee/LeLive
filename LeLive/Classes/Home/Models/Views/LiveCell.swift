//
//  LiveCell.swift
//  LeLive
//
//  Created by Nicholas Lee on 2017/2/27.
//  Copyright © 2017年 Nicholas Lee. All rights reserved.
//

import UIKit
import Kingfisher

class LiveCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var online_usersLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var sentenceLabel: UILabel!
    
    var liveObj = LiveObj() {
        
        didSet {
            self.nickLabel.text = liveObj.creator.nick
            if liveObj.city == "" {
                self.cityLabel.text = "Maybe from Mars?"
            } else {
                self.cityLabel.text = liveObj.city
            }
            self.online_usersLabel.text = "\(liveObj.online_users)"
            self.iconImageView.kf.setImage(with: URL.init(string: liveObj.creator.portrait))
            self.mainImageView.kf.setImage(with: URL.init(string: liveObj.creator.portrait))
            self.iconImageView.layer.cornerRadius = 20;
            self.iconImageView.clipsToBounds = true;
            self.sentenceLabel.text = liveObj.name
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
