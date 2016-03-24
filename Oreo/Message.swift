//
//  Message.swift
//  Oreo
//
//  Created by Shimpei Otsubo on 3/25/16.
//  Copyright © 2016 Mikan Laboratories. All rights reserved.
//

import Foundation

class Message {
    var type: MessageType
    var target: Position?
    var is_success: Bool?
    
    init (type: MessageType, target: Position, result: Bool){
        self.type = type
        self.target = target
        self.is_success = result
    }
    
    enum MessageType {
        case Attack
        case Result
    }
}

extension NSData {
    func unpackMessage() -> Message {
        let pointer = UnsafeMutablePointer<Message>.alloc(sizeof(Message.Type))
        self.getBytes(pointer, length: sizeof(Message.Type))
        return pointer.move()
    }
    class func packMessage(raw_value: Message) -> NSData {
        var value = raw_value
        return withUnsafePointer(&value) { p in
            NSData(bytes: p, length: sizeofValue(value))
        }
    }
}
