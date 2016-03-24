//
//  Field.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

class Position{
    var x:Int
    var y:Int
    init(x:Int,y:Int){
        self.x = x
        self.y = y
    }
}

class Field :UIView {
    
    enum Cell {
        case Ship
        case Blank
        case attacked_Ship
        case attacked_Blank
    }
    
    static let fieldSize = 5
    static var cell_line = Array(count: fieldSize, repeatedValue: Cell.Blank)
    var cell_arr = Array(count: fieldSize, repeatedValue: cell_line)
    
    func burn_at(pos:Position, completion:(Cell)->Void){
        print(cell_arr[pos.x][pos.y])
        switch cell_arr[pos.x][pos.y]{
        case .Blank:
            cell_arr[pos.x][pos.y] = .attacked_Blank
            completion(.Blank)
        case .Ship:
            cell_arr[pos.x][pos.y] = .attacked_Ship
            completion(.Ship)
        case .attacked_Blank:
            // TODO: 処理書く
            completion(.attacked_Blank)
        case .attacked_Ship:
            // TODO: 処理書く
            completion(.attacked_Ship)
        }
    }
    
    func miss_at(pos:Position){
        // TODO:水しぶき実装
    }
    
}

class OwnField :Field{
    var selected_cell = Position(x: -1, y: -1)
    
    func attack_at(pos:Position){
        
    }
}

class EnemyField :Field{
    
    func attacked_at(pos:Position){
        
    }
}
