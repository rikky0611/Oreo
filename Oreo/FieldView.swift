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
    //func sendMessage(msg: Message) -> Bool;
}

class FieldView :UIView {
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let field = Field()
    
    func initialize(){
        let boardSize = CGSizeMake(screenWidth,screenHeight)
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
        let x = btn.tag % fieldSize
        let y = btn.tag / fieldSize
        print("x:\(x),y:\(y)")
        let pos = Position(x: x,y: y)
        self.field.burn_at(pos){(status) in
            if status == Field.Cell.Blank {
                btn.backgroundColor = UIColor.blackColor()
                do{
                    try self.session.sendData(msg!, toPeers: self.session.connectedPeers,
                                              withMode: MCSessionSendDataMode.Unreliable)

                }catch{
                    //えらー
                }
            }else if status == Field.Cell.Ship{
                btn.backgroundColor = UIColor.yellowColor()
            }else{
                
            }
        }
    }
}