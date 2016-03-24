//
//  Position.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation

class Position{
    var x:Int
    var y:Int
    init(x:Int,y:Int){
        self.x = x
        self.y = y
    }
}

class Vector:Position{
    func multiple(i:Int) -> Vector{
        let x = self.x * i
        let y = self.y * i
        return Vector(x: x, y: y)
    }
}