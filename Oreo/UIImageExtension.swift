//
//  UIImageExtension.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/25.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func resizeShorterLength(img:UIImage,newValue:CGFloat)->UIImage{
        let size = CGSize(width:newValue*5,height:newValue)
        UIGraphicsBeginImageContext(size)
        img.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizeImage
    }
}
