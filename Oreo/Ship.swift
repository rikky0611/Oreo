//
//  Ship.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

enum Type{
    case Carrier    //空母 5マス
    case Battlecruiser  //巡洋戦艦 4マス
    case Cruiser    //巡洋艦 3マス
    case Submarine  //潜水艦 3マス
    case Destroyer  //駆逐艦 2マス
}

class Ship {
    
    var position : Position //頭の位置
    var direction : Direction
    var type : Type
    var length : CGFloat
    let size : Int
    var image : UIImage!
    init(pos:Position,dir:Direction,type:Type){
        self.position = pos
        self.direction = dir
        self.type = type
        switch type{
        case .Carrier: self.size = 5;self.image = UIImage(named:"carrier.png")
        case .Battlecruiser: self.size = 4;self.image = UIImage(named:"battlecruiser.png")
        case .Cruiser: self.size = 3;self.image = UIImage(named:"cruiser.png")
        case .Submarine: self.size = 3;self.image = UIImage(named:"submarine.png")
        case .Destroyer: self.size = 2;self.image = UIImage(named:"destroyer.png")
        }
        self.length = UIScreen.mainScreen().bounds.size.width / CGFloat(Field.fieldSize)    //btnサイズと同じ
    }
    
    func rotate90degrees(){
       // TODO:正の向きに90度回転させるメソッド
        self.direction.dirNum = (self.direction.dirNum+1)%4
    }
    
    
    func isAbleToPut(){
    // TODO:置けるか判定するメソッド
    }
    
}
