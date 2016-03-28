//
//  Message.swift
//  Oreo
//
//  Created by Shimpei Otsubo on 3/25/16.
//  Copyright © 2016 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit

struct Message {
    var type: MessageType
    var target: Position
    var is_success: Bool
    
    enum MessageType: String {
        case Attack = "Attack"
        case Result = "Result"
        
    }
    
    init (type: MessageType, target: Position, result: Bool){
        self.type = type
        self.target = target
        self.is_success = result
    }
    
    init?(json: String){
        print(json)
        var dict: [String:String] = [:]
        if let data = json.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as! [String:String]
            }catch{
                
            }
        }

        self.type = MessageType(rawValue: dict["type"] ?? "Attack")!
        self.target = Position(x: Int(dict["x"] ?? "0")!, y: Int(dict["y"] ?? "0")!)
        self.is_success = (dict["result"] ?? "false")!.toBool()!
        print(description)
    }
    
    func toJson() -> String {
        let dict = ["type": String(self.type), "x": String(self.target.x), "y": String(self.target.y), "result": String(self.is_success)]
        var jsonData = NSData()
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions())
        }catch{
            
        }
        
        return NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
    }
    
    func convertStringToDictionary(text: String) -> [String:String]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String:String]
            }catch{
                
            }
        }
        return nil
    }
    
    var description: String {
        return "\(self.type) + \(self.target.x) + \(self.target.y) + \(self.is_success)"
    }
}

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}