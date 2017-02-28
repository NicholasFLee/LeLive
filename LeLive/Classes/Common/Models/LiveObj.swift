//
//  LiveObj.swift
//  LeLive
//
//  Created by Nicholas Lee on 2017/2/27.
//  Copyright © 2017年 Nicholas Lee. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

var canRefresh: Bool = false

class LiveObj: NSObject {
    
    var creator = CreatorObj()
    var liveid = String()
    var name = String()
    var city = String()
    var share_addr = String()
    var stream_addr = String()
    var slot = NSNumber()
    var online_users = NSNumber()
    
//    let labels: Array
    
    override init() {
        super.init()
    }
    
    
    init(a: NSMutableArray, t: UITableView) {
        a.removeAllObjects()
        let url = URL.init(string: "http://116.211.167.106/api/live/aggregation?uid=314181862&interest=1")
        
        Alamofire.request( url!).responseJSON { (response) in
            let dic = try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! NSDictionary
            let lives = dic["lives"] as! NSArray
            
            for i in 0...199 {
                
                let obj = LiveObj.init()
                let creator = CreatorObj.init()
                
                let live = lives[i] as! NSDictionary
                let creDic = live["creator"] as! NSDictionary
                
                creator.uid = creDic["id"] as! NSNumber
                creator.level = creDic["level"] as! NSNumber
                creator.gender = creDic["gender"] as! NSNumber
                creator.nick = creDic["nick"] as! String
                creator.portrait = creDic["portrait"] as! String
                
                obj.creator = creator
                obj.liveid = live["id"] as! String
                obj.name = live["name"] as! String
                obj.city = live["city"] as! String
                obj.share_addr = live["share_addr"] as! String
                obj.stream_addr = live["stream_addr"] as! String
                obj.slot = live["slot"] as! NSNumber
                obj.online_users = live["online_users"] as! NSNumber
                a.add(obj)
                
            }
            
            canRefresh = true
            t.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    
    
    
    
}
