//
//  HomeViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 2017/2/27.
//  Copyright © 2017年 Nicholas Lee. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    var dataSource = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        self.tableView.separatorStyle = .none
        _ = LiveObj.init(a: dataSource, t: self.tableView)
        
        self.tableView.register(UINib.init(nibName: "LiveCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! LiveCell
        cell.liveObj = dataSource[indexPath.row] as! LiveObj
        

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
