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
    
    func shift(x x:Int, y:Int) -> Position{
        return Position(x:self.x+x, y:self.y+y)
    }
    
    func to_i() -> Int {
        return (x + y)*(x + y) + y
    }
    
    func move(by: Int, dir: Direction) -> Position{
        return Position(x: self.x + dir.vector.x, y: self.y + dir.vector.y)
    }
}

class Vector:Position{
    func multiple(i:Int) -> Vector{
        let x = self.x * i
        let y = self.y * i
        return Vector(x: x, y: y)
    }
}

extension Int {
    func to_p() -> Position {
        let a = Int(sqrt(Double(self)))
        let y = self - a*a
        let x = Int(sqrt(Double(self))) - y
        return Position(x: x, y: y)
    }
}
