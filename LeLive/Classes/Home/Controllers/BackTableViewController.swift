//
//  BackTableViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 03/04/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

class BackTableViewController: UITableViewController {
    
    let backReuse = "backReuse"
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: backReuse)
        tableView.showsVerticalScrollIndicator = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: backReuse, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Video"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Audio"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Manual"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "Camera"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let si = indexPath.row
        if currentPage == si {
            drawerController?.closeDrawer(animated: true, completion: nil)
            return
        }
        currentPage = si
        backSelectClosure(si)
        drawerController?.closeDrawer(animated: true, completion: nil)
    }

}
