//
//  HomeViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 2017/2/27.
//  Copyright © 2017年 Nicholas Lee. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import SVProgressHUD

class HomeViewController: UITableViewController {

    var dataSource = NSMutableArray()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "加载数据中!")
        self.title = "List"
        self.tableView.separatorStyle = .none
        _ = LiveObj.init(a: dataSource, t: self.tableView)
        
        self.tableView.register(UINib.init(nibName: "LiveCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.dg_addPullToRefreshWithActionHandler({
            if canRefresh {
                canRefresh = false
                _ = LiveObj.init(a: self.dataSource, t: self.tableView)
                SVProgressHUD.setMaximumDismissTimeInterval(2)
                SVProgressHUD.setDefaultMaskType(.gradient)
                SVProgressHUD.showSuccess(withStatus: "刷新完成!")
                
            } else {
                SVProgressHUD.setMaximumDismissTimeInterval(2)
                SVProgressHUD.showError(withStatus: "刚刚刷新过哦!")
            }
            self.tableView.dg_stopLoading()
        }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
        
    }
    
    deinit {
        
        
        tableView.dg_removePullToRefresh()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! LiveCell
        if dataSource.count > indexPath.row {
            cell.liveObj = dataSource[indexPath.row] as! LiveObj
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let l = LiveViewController()
        l.obj = dataSource[indexPath.row] as! LiveObj
        self.navigationController?.pushViewController(l, animated: true)
    }


}
