//
//  Alert.swift
//  Oreo
//
//  Created by 松田冬樹 on 3/30/16.
//  Copyright © 2016 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

class Alert :UIAlertController{
    
    private func presentViewController(alert: UIAlertController, animated flag: Bool, completion: (() -> Void)?) -> Void {
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: flag, completion: completion)
    }
    
    func attacked(){
        self.setAlert("攻撃を受けました。")
    }
    func attackedAndBurned(){
        self.setAlert("攻撃を受け、船の一部が炎上しました。")
    }
    func attackSucceed(){
        self.setAlert("攻撃が成功しました。")
    }
    func attackMissed(){
        self.setAlert("攻撃は失敗しました。")
    }
    
    
    func setAlert(message:String){
        let alert:UIAlertController = UIAlertController(title: "警告", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            action in
            // ボタンが押された時の処理
            print ("pushed")
        }))
        self.presentViewController(alert, animated: true, completion: {
            // 表示完了時の処理
            print("finished")
        })
    }
}