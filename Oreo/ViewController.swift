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
    let fieldSize = Field.fieldSize
    let boardView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialize()
    }
    
    func initialize(){

        let boardSize = CGSizeMake(screenWidth,screenHeight)
        let boardOrigin = CGPointMake(0,(screenHeight - boardSize.height)/2)
        
        boardView.frame.origin = boardOrigin
        boardView.frame.size = boardSize
        self.view.addSubview(boardView)
        
        let btnSize = boardSize.width/CGFloat(fieldSize)
        
        for var y = 0; y<fieldSize; y++ {
            for var x = 0;x<fieldSize;x++ {
                let btn = UIButton(frame: CGRectMake(btnSize * CGFloat(x),btnSize * CGFloat(y),btnSize, btnSize))
                btn.layer.borderWidth = 2.0
                btn.layer.borderColor = UIColor.grayColor().CGColor
                boardView.addSubview(btn)
                
                btn.tag = y*fieldSize + x
                btn.addTarget(self, action:Selector("onBtnClick:") , forControlEvents: .TouchUpInside)
                
            }
        }
    }
    
    func onBtnClick(btn: UIButton){
        let x = btn.tag % fieldSize
        let y = btn.tag / fieldSize
        print("x:\(x),y:\(y)")
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

