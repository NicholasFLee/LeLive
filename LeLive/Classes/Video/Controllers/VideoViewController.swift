//
//  VideoViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 2017/2/27.
//  Copyright © 2017年 Nicholas Lee. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh

let CELLHEIGHT: CGFloat = 500.0
let INPAGE = 10

class VideoViewController: UITableViewController {

    var dataSource = NSMutableArray()
    var currentDSCount = INPAGE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.7036997676, green: 0.9950520396, blue: 0.9879503846, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        SVProgressHUD.show(withStatus: "加载数据中!")
        self.title = "List"
        self.tableView.separatorStyle = .none
        
//        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonDidClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "live", style: .done, target: self, action: #selector(rightBarButtonDidClick))
        
        _ = LiveObj.init(a: dataSource, t: self.tableView)
        self.tableView.register(UINib.init(nibName: "LiveCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
                _ = LiveObj.init(a: self.dataSource, t: self.tableView)
        })
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            if self.currentDSCount < 200 {
                self.currentDSCount += INPAGE
                self.tableView.reloadData()
            }
        })
    }
    
    func rightBarButtonDidClick() {
        self.navigationController?.present(TransmitViewController(), animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDSCount//dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! LiveCell
        if dataSource.count > indexPath.row {
            cell.liveObj = dataSource[indexPath.row] as! LiveObj
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELLHEIGHT
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.mj_header.isRefreshing() {
            return
        }
        
        let l = LiveViewController()
        l.obj = dataSource[indexPath.row] as! LiveObj
        self.navigationController?.pushViewController(l, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.tableView.mj_footer.isRefreshing() {
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
