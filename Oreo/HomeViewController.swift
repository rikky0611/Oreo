//
//  HomeViewController.swift
//  Oreo
//
//  Created by Shimpei Otsubo on 3/28/16.
//  Copyright © 2016 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let ownFieldView = FieldView()
    let enemyFieldView = FieldView()
    
    func showMenu() {
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("Single Playper Mode", forState: UIControlState.Normal)
        button.addTarget(self, action: "startSinglePlayerGame:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        showMenu()
    }
    
    func startSinglePlayerGame(sender: UIButton) {
        let gameViewController = GameViewController()
        self.presentViewController(gameViewController, animated: true, completion: nil)
    }
    
}