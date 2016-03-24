//
//  Direction.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation

class Direction {
    var dirNum : Int
    var vector: Vector
    init(direction:Int){
        self.dirNum = direction
        self.vector = Vector(x: 0, y: 0)
        switch direction{
        case 0: self.vector = Vector(x: 1, y: 0)
        case 1: self.vector = Vector(x: 0, y: 1)
        case 2: self.vector = Vector(x: -1, y: 0)
        case 3: self.vector = Vector(x: 0, y: -1)
        default: break
        }
    }
}

