//
//  ShipView.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

class ShipView : UIView {
    var view : UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func addShip(ship:Ship){
        let image = ship.image
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
