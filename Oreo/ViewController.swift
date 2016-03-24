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
    let boardView = Field()
    
    //MARK:テスト用
    var dir : Direction!
    var pos : Position!
    var ship : Ship!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialize()
        
        //MARK:テスト用
        pos = Position(x:2,y:2)
        dir = Direction(direction: 0)
        ship = Ship(pos: pos, dir: dir, type: Type.Submarine)
        let shipView = ShipView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        view.addSubview(shipView)
        view.sendSubviewToBack(shipView)    //shipViewを最背面に
        shipView.addShip(ship)
    }
    
    func initialize(){

        let boardSize = CGSizeMake(screenWidth,screenHeight)
        let boardOrigin = CGPointMake(0,(screenHeight - boardSize.height)/2)
        
        boardView.frame.origin = boardOrigin
        boardView.frame.size = boardSize
        self.view.addSubview(boardView)
        
        let btnSize = boardSize.width/CGFloat(fieldSize)
        
        for y in 0 ..< fieldSize {
            for x in 0 ..< fieldSize {
                let btn = UIButton(frame: CGRectMake(btnSize * CGFloat(x),btnSize * CGFloat(y),btnSize, btnSize))
                btn.layer.borderWidth = 2.0
                btn.layer.borderColor = UIColor.grayColor().CGColor
                boardView.addSubview(btn)
                
                btn.tag = y*fieldSize + x
                btn.alpha = 0.7
                btn.addTarget(self, action:"onBtnClick:" , forControlEvents: .TouchUpInside)
                
            }
        }
    }
    
    func onBtnClick(btn: UIButton){
        let x = btn.tag % fieldSize
        let y = btn.tag / fieldSize
        print("x:\(x),y:\(y)")
        let pos = Position(x: x,y: y)
        boardView.burn_at(pos){(status) in
            if status == Field.Cell.Blank {
                btn.backgroundColor = UIColor.blackColor()
            }else if status == Field.Cell.Ship{
                btn.backgroundColor = UIColor.yellowColor()
            }else{
                self.setAlert("そこには大砲を打てません")
            }
        }
    }
    
    func setAlert(message:String){
        let alert:UIAlertController = UIAlertController(title: "警告", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            action in
            // ボタンが押された時の処理
            print ("pushed")
        }))
        self.presentViewController(alert, animated: true, completion: {
            // 表示完了時の処理
            print("finished")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

