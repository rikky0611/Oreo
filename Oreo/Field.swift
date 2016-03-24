//
//  Field.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation

class Field {
    
    enum Cell {
        case Ship
        case Blank
        case attacked_Ship
        case attacked_Blank
    }
    
    static let fieldSize = 5
    static var cell_line = Array(count: fieldSize, repeatedValue: Cell.Blank)
    var cell_arr = Array(count: fieldSize, repeatedValue: cell_line)
    
    func burn_at(x x:Int,y:Int){
        switch cell_arr[x][y]{
        case Cell.Blank:
            cell_arr[x][y] = Cell.attacked_Blank
        case Cell.Ship:
            cell_arr[x][y] = Cell.attacked_Ship
        case Cell.attacked_Blank:
            // TODO: 処理書く
            break
        case Cell.attacked_Ship:
            // TODO: 処理書く
            break
        }
    }
    
    
}
