//
//  Field.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

let fieldSize = 5

enum Cell {
    case Ship
    case Blank
    case attacked_Ship
    case attacked_Blank
}

protocol FieldDelegate {
    func markBurnedAt(pos: Position)
}

class Field :UIView {
    
    enum Cell {
        case Ship
        case Blank
        case attacked_Ship
        case attacked_Blank
    }
    
    //static let fieldSize = 5
    static var cell_line = Array(count: fieldSize, repeatedValue: Cell.Blank)
    var cell_arr = Array(count: fieldSize, repeatedValue: cell_line)
    var delegate: FieldDelegate!
    
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
    
    func is_attackable (pos: Position) -> Bool{
        switch cell_arr[pos.x][pos.y] {
        case .attacked_Ship, .attacked_Blank:
            return false
        default:
            return true
        }
    }
    
    func miss_at(pos:Position){
        // TODO:水しぶき実装
    }
    
    func reallocate(ships:Ships){
        // 配置フェーズで使用することのみ想定
        let cell_line = Array(count: fieldSize, repeatedValue: Cell.Blank)
        self.cell_arr = Array(count: fieldSize, repeatedValue: cell_line)
        for ship in ships.shipArray{
            for i in 0..<ship.size{
                let shift = ship.direction.vector.multiple(i)
                self.cell_arr[ship.position.x+shift.x][ship.position.y+shift.y] = Cell.Ship
            }
        }
    }
    
    func isInField(pos:Position) -> Bool{
        return pos.x >= 0 && pos.x < fieldSize && pos.y >= 0 && pos.y < fieldSize
    }
    
    func isBlank(pos:Position) -> Bool{
        return self.cell_arr[pos.x][pos.y]==Cell.Blank
    }
    
    func getAttackedAt(pos:Position) -> Bool{
        let status = cell_arr[pos.x][pos.y]
        cell_arr[pos.x][pos.y] = .attacked_Blank
        delegate.markBurnedAt(pos)
        
        switch status {
        case .attacked_Ship:
            return true
        default:
            return false
        }
    }
    
    func setCell(pos: Position, status: Cell){
        cell_arr[pos.x][pos.y] = status
    }
    
    func putShip(pos: Position, dir: Direction, ship: Ship) {
        for i in 0..<ship.type.shipLength() {
            let p = pos.move(i, dir: dir)
            setCell(p, status: .Ship)
        }
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
