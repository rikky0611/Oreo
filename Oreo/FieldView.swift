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
    func btnActionOf(of: Position, from: FieldView.Side)
}

class FieldView :UIView, FieldDelegate {
    enum Side {
        case Enemy
        case Own
        func theOther() ->Side{
            switch self {
            case .Enemy:
                return FieldView.Side.Own
            case .Own:
                return FieldView.Side.Enemy
            }
        }
    }

    var side: Side = .Enemy
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    var delegate: FieldViewDelegate!
    
    func initialize(side :Side){
        self.side = side // own or enemy
        
        let boardSize = CGSizeMake(screenWidth*8/9,screenWidth*8/9)
        self.left = screenWidth*8/18
        let boardOrigin = CGPointMake(0,(screenHeight - boardSize.height)/2)
        self.frame.origin = boardOrigin
        self.frame.size = boardSize
        
        let btnSize = boardSize.width/CGFloat(fieldSize)
        
        // placing buttons
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
    
    // onBtnClicks
    func onBtnClick(btn: UIButton){
        // considering only the case attacking enemy field view
        let pos = btn.tag.to_p()
        switch self.side {
        case .Own:
            onBtnClickOwn(pos)
        default:
            onBtnClickEnemy(pos)
        }
    }
    
    func onBtnClickOwn(pos: Position) {
        
    }
    
    func onBtnClickEnemy(pos: Position){
        self.delegate.btnActionOf(pos, from: self.side)
    }
    
    
    // marking funcs
    func markMissedAt(pos: Position){
        let btn = self.viewWithTag(pos.to_i()) as? UIButton
        btn?.backgroundColor = UIColor.blueColor()
    }
    
    func markBurnedAt(pos: Position) {
        let btn = self.viewWithTag(pos.to_i()) as? UIButton
        btn?.backgroundColor = UIColor.blackColor()
    }
    
    func putShip(pos: Position, dir: Direction, ship: Ship) {
        if self.side == .Own {
            let shipView = ShipView(frame: CGRectMake(0,0,self.frame.width,self.frame.height))
            self.addSubview(shipView)
            self.sendSubviewToBack(shipView)    //shipViewを最背面に
            shipView.addShip(ship)
        }
    }
}