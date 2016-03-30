//
//  GameViewController.swift
//  Oreo
//
//  Created by Shimpei Otsubo on 3/28/16.
//  Copyright © 2016 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

class SingleGameViewController: UIViewController, FieldViewDelegate, FieldDelegate {
    
    var fieldViews: [FieldView.Side:FieldView] = [:]
    var fields:     [FieldView.Side:Field]     = [:]
    
    // MultipeerConnectivity Settings
    let serviceType = "mikanlabsoreo" // unique service name
    
    enum GameType {
        case SinglePlaper
        case MultiPlayer
    }
    
    var gameType: GameType = .SinglePlaper
    var toShowBrowser = true

    func initialize(type: GameType) {
        self.gameType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        putBothView()
        self.view.backgroundColor = UIColor.whiteColor()
        
        // for test
        let pos = Position(x:2,y:2)
        let dir = Direction(direction: 0)
        let ship = Ship(pos: pos, dir: dir, type: Type.Submarine)
        
        for (side,_) in fields {
            self.putShip(side, pos: pos, dir: dir, ship: ship)
        }
        
        
    }
    
    func putShip(side: FieldView.Side, pos: Position, dir: Direction, ship: Ship) {
        fields[side]?.putShip(pos, dir: dir, ship: ship)
        fieldViews[side]?.putShip(pos, dir: dir, ship: ship)
    }
    
    func putBothView() {
        fieldViews[FieldView.Side.Own]   = FieldView()
        fieldViews[FieldView.Side.Enemy] = FieldView()
        
        for (side, view) in self.fieldViews {
            print("\(side)")
            view.delegate = self
            view.initialize(side)
            self.view.addSubview(view)
            
            self.fields[side] = Field()
        }
        fieldViews[FieldView.Side.Own]!.bottom = self.view.bottom
        fieldViews[FieldView.Side.Enemy]!.top  = self.view.top
    }
    
    func btnActionOf(of: Position, from: FieldView.Side) {
        
        // if shipplacing Phase
        if from == FieldView.Side.Own {
            // some ship placing func
            return
        }
        
        // if my turn
        if from == FieldView.Side.Enemy {
            if !self.fields[from.theOther()]!.is_attackable(of) {
                print("you can't attack there")
                return // alert you can't attack there
            }
            self.fields[from.theOther()]!.getAttackedAt(of)
            guard let status = self.fields[from.theOther()]!.statusAt(of) else {
                print("Unexpected Error")
                return
            }
            
            if status == .attacked_Ship {
                fieldViews[from]!.markBurnedAt(of)
                print("Attack Succeeded")
            } else {
                fieldViews[from]!.markMissedAt(of)
                print("Attack Failed")
            }
        }
    }
}