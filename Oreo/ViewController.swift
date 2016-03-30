//
//  ViewController.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    //HomeViewController
    var home = HomeViewController()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.presentViewController(home, animated: true, completion: nil)
    }
}

