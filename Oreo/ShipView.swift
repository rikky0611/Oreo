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
        let btnSize = self.frame.width / CGFloat(fieldSize)
        let image = ship.image.resize(ratio: btnSize/ship.image.size.height)
        let x:CGFloat = CGFloat(ship.position.x) * btnSize
        let y:CGFloat = CGFloat(ship.position.y) * btnSize
        let imageView = UIImageView(frame: CGRectMake(x,y,image.size.width,image.size.height))
        imageView.image = image
        self.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
