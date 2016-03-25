//
//  FieldView.swift
//  Oreo
//
//  Created by Shimpei Otsubo on 3/25/16.
//  Copyright © 2016 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

protocol FieldViewDelegate {
    func sendMessage(msg: Message) -> Bool;
}

class FieldView :UIView {
    enum Side {
        case Enemy
        case Own
    }
    var side: Side = .Enemy
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let field = Field()
    var delegate: FieldViewDelegate!
    
    func initialize(side :Side){
        self.side = side
        
        let boardSize = CGSizeMake(screenWidth*8/9,screenWidth*8/9)
        self.left = screenWidth*8/18
        let boardOrigin = CGPointMake(0,(screenHeight - boardSize.height)/2)
        self.frame.origin = boardOrigin
        self.frame.size = boardSize
        
        let btnSize = boardSize.width/CGFloat(fieldSize)
        
        for y in 0 ..< fieldSize {
            for x in 0 ..< fieldSize {
                let btn = UIButton(frame: CGRectMake(btnSize * CGFloat(x),btnSize * CGFloat(y),btnSize, btnSize))
                btn.layer.borderWidth = 2.0
                btn.layer.borderColor = UIColor.grayColor().CGColor
                self.addSubview(btn)
                
                btn.tag = y*fieldSize + x
                btn.alpha = 0.7
                btn.addTarget(self, action:"onBtnClick:" , forControlEvents: .TouchUpInside)
            }
        }
    }
    
    func onBtnClick(btn: UIButton){
        // considering only the case attacking enemy field view
        let x = btn.tag % fieldSize
        let y = btn.tag / fieldSize
        print("x:\(x),y:\(y)")
        let pos = Position(x: x,y: y)
        switch self.side {
        case .Own:
            onBtnClickOwn(pos)
            // for test, to be deleted
            btn.backgroundColor = UIColor.blackColor()
        default:
            onBtnClickEnemy(pos)
        }
    }
    
    func onBtnClickOwn(pos: Position) {
        
    }
    
    func onBtnClickEnemy(pos :Position){
        if !field.is_attackable(pos) {
            // alert you can't attack there
            return
        }
        
        let msg = Message(type: .Attack, target: pos, result: true)
        self.delegate!.sendMessage(msg)
    }
}