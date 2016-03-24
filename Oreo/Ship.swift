//
//  Ship.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation

class Ship {
    enum Type{
        case Carrier    //空母 5マス
        case Battlecruiser  //巡洋戦艦 4マス
        case Cruiser    //巡洋艦 3マス
        case Submarine  //潜水艦 3マス
        case Destroyer  //駆逐艦 2マス
    }
    
    var position : Position
    var direction  : Direction
    
    init(position:Position,direction:Direction){
        self.position = position
        self.direction = direction
    }
}
