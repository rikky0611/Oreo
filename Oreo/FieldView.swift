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

class FieldView :UIView, FieldDelegate {
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
        self.side = side // own or enemy
        
        field.delegate = self
        
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
                
                btn.tag = Position(x: x, y: y).to_i()
                btn.alpha = 0.7
                btn.addTarget(self, action:"onBtnClick:" , forControlEvents: .TouchUpInside)
            }
        }
    }
    
    func onBtnClick(btn: UIButton){
        // considering only the case attacking enemy field view
        let pos = btn.tag.to_p()
        switch self.side {
        case .Own:
            onBtnClickOwn(pos)
        default:
            print("will call onBtnClickEnemy")
            onBtnClickEnemy(pos)
        }
        print("didCallonBtnClickEnemy")
    }
    
    func onBtnClickOwn(pos: Position) {
        
    }
    
    func onBtnClickEnemy(pos: Position){
        if !field.is_attackable(pos) {
            // alert you can't attack there
            return
        }
        
        let msg = Message(type: .Attack, target: pos, result: true)
        self.delegate!.sendMessage(msg)
    }
    
    func getAttackedAt(pos: Position) {
        let is_effective = field.getAttackedAt(pos)
        let msg = Message(type: .Result, target: pos, result: is_effective)
        delegate.sendMessage(msg)
    }
    
    func markMissedAt(pos: Position){
        let btn = self.viewWithTag(pos.to_i()) as? UIButton
        btn?.backgroundColor = UIColor.blueColor()
    }
    
    func markBurnedAt(pos: Position) {
        let btn = self.viewWithTag(pos.to_i()) as? UIButton
        btn?.backgroundColor = UIColor.blackColor()
    }
}