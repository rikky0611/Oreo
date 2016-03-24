//
//  BoardView.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

final class FieldView: UIView {
    
    static let screenWidth = UIScreen.mainScreen().bounds.size.width
    static let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    class func createCells(view:UIView){
        let fieldSize = Field.fieldSize
        let fieldLength = CGSizeMake(screenWidth,screenHeight)
        
        //let fieldOrigin = CGPointMake(0,(screenHeight - fieldLength.height)/2)
        let btnSize = fieldLength.width/CGFloat(fieldSize)

        for var y = 0; y<fieldSize; y++ {
            for var x = 0;x<fieldSize;x++ {
                let btn = UIButton(frame: CGRectMake(btnSize * CGFloat(x),btnSize * CGFloat(y),btnSize, btnSize))
                btn.layer.borderWidth = 2.0
                btn.layer.borderColor = UIColor.grayColor().CGColor
                view.addSubview(btn)
                btn.tag = y*fieldSize + x
                btn.addTarget(view, action:Selector("onBtnClick:") , forControlEvents: .TouchUpInside)
            }
        }
        
        func onBtnClick(btn: UIButton){
            let x = btn.tag % fieldSize
            let y = btn.tag / fieldSize
            print("x:\(x),y:\(y)")
        }
    }
    
    
    

}
