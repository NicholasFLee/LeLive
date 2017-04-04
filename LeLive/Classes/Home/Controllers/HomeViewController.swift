//
//  HomeViewController.swift
//  LeLive
//
//  Created by Nicholas Lee on 27/03/2017.
//  Copyright © 2017 Nicholas Lee. All rights reserved.
//

import UIKit

let ENDBOUNDS = CGRect.init(x: (2 / 3) * WIDTH, y: 0, width: WIDTH, height: HEIGHT)
let ENDX = (2 / 3) * WIDTH
let HALFENDX = 0.5 * ENDX
let TWOENDX = 0.2 * ENDX
let NINEENDX = 0.9 * ENDX
var CLOSEFROMX: CGFloat = 0
var OPENFROMX: CGFloat = 0
var MOVEMAXX: CGFloat = 0
var atBegin = true
var atEnd = false

class HomeViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    let containView = UIView.init(frame: BOUNDS)
    var currentPage = 0
    var currentX: CGFloat = 0.0
    let VideoVC = UINavigationController.init(rootViewController: VideoViewController())
    let AudioVC = UINavigationController.init(rootViewController: AudioViewController())
    var backCurrentX: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        view.backgroundColor = UIColor.black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        let panGesture = UIPanGestureRecognizer.init(target: self, action:#selector(pan(pg:)))
        panGesture.maximumNumberOfTouches = 1
        view.addGestureRecognizer(panGesture)
        containView.backgroundColor = UIColor.purple
        view.addSubview(containView)
        self.addChildViewController(VideoVC)
        self.addChildViewController(AudioVC)
        containView.addSubview(VideoVC.view)
    }
    
    func pan(pg: UIPanGestureRecognizer) {
        print("currentX: \(currentX)")
        let location = pg.location(in: self.view)
        let veloX = pg.velocity(in: view).x
        if pg.state.rawValue == 1 {
            if atBegin {
                CLOSEFROMX = location.x
            } else if atEnd {
                OPENFROMX = location.x
            }
        }
        if (atBegin && veloX < 0) || (atEnd && veloX > 0){
            return
        }
        if atEnd {
            UIView.animate(withDuration: 0.2, animations: {
                self.containView.frame = BOUNDS
            })
            atEnd = false
            atBegin = true
            return
        }
        if veloX > 0 {
            currentX = location.x - CLOSEFROMX
            OPENFROMX = location.x
            backCurrentX = currentX
        } else if veloX < 0 {
            if atEnd {
                currentX = ENDX - (OPENFROMX - location.x)
                CLOSEFROMX = location.x - currentX
            } else {
               currentX = backCurrentX - (OPENFROMX - location.x)
            }
        }
        guard currentX >= 0 && currentX <= ENDX else {
            return
        }
        if !atBegin && !atEnd {
            
        }
        
        containView.frame = CGRect.init(x: currentX, y: 0, width: WIDTH, height: HEIGHT)
        
        atBegin = false
        atEnd = false
        if currentX >= ENDX {
            self.containView.frame = ENDBOUNDS
            atEnd = true
            currentX = ENDX
        } else if currentX <= 0 {
            self.containView.frame = BOUNDS
            atBegin = true
            currentX = 0
        }

        // finger out of screen
        if pg.state.rawValue == 3 || pg.state.rawValue == 4 {
            if veloX < 0 {
                if currentX < NINEENDX{
                    UIView.animate(withDuration: 0.2, animations: {
                        self.containView.frame = BOUNDS
                    })
                    atBegin = true
                    currentX = 0
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.containView.frame = ENDBOUNDS
                    })
                    atEnd = true
                    currentX = ENDX
                }
            } else {
                if currentX < TWOENDX {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.containView.frame = BOUNDS
                    })
                    atBegin = true
                    currentX = 0
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.containView.frame = ENDBOUNDS
                    })
                    atEnd = true
                    currentX = ENDX
                }
            }
        }
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        cell.backgroundColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.textLabel?.text = "Video"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Audio"
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click at \(indexPath.row)")
        UIView.animate(withDuration: 0.2) { 
            self.containView.frame = BOUNDS
        }
        atBegin = true
        atEnd = false
        currentX = 0
        guard indexPath.row != currentPage else {
            return
        }
        
        if indexPath.row == 0 {
            currentPage = 0
            self.containView.addSubview(VideoVC.view)
        } else if indexPath.row == 1 {
            currentPage = 1
            self.containView.addSubview(AudioVC.view)
        }
    }
    
    
    
    
    
  

}
