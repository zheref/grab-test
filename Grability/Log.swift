//
//  Log.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/2/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

enum DebugLevel: Int {
    case VERBOSE = 4
    case DEBUG = 3
    case WARNING = 2
    case ERROR = 1
}

enum LogColor: Int {
    case Black = 30
    case Red = 31
    case Green = 32
    case Yellow = 33
    case Blue = 34
    case Magenta = 35
    case Cyan = 36
    case White = 37
}

enum LogAttribute: Int {
    case Bold = 0
    case Dim = 1
    case Normal = 2
}

internal class Log {
    
    static var debugLevel: DebugLevel = DebugLevel.DEBUG;
    
    class func notifyTrigger(eventName: String) {
        debug("\(eventName) has been triggered");
    }
    
    class func notifyTrigger(eventName: String, under tag: String) {
        debug("\(tag): \(eventName) has been triggered inside");
    }
    
    class func debug(text: String) {
        if (debugLevel.rawValue >= DebugLevel.DEBUG.rawValue) {
            Swift.print(">>> DEBUG: \(text)");
            //print(">>> DEBUG: \(text)", withColor: LogColor.Blue, andAttribute: LogAttribute.Bold);
        }
    }
    
    class func debug(tag: String, print text: String) {
        if (debugLevel.rawValue >= DebugLevel.DEBUG.rawValue) {
            Swift.print("[\(tag)] >>> DEBUG: \(text)");
            //print(">>> DEBUG: \(text)", withColor: LogColor.Blue, andAttribute: LogAttribute.Bold);
        }
    }
    
    class func error(text: String) {
        if (self.debugLevel.rawValue >= DebugLevel.ERROR.rawValue) {
            Swift.print(">>> ERROR: \(text)");
        }
    }
    
    class func error(tag: String, print text: String) {
        if (self.debugLevel.rawValue >= DebugLevel.ERROR.rawValue) {
            Swift.print("[\(tag)] >>> ERROR: \(text)");
        }
    }
    
    class func print(text: String, withColor color: LogColor, andAttribute attribute: LogAttribute) {
        Swift.print("\u{001B}[\(attribute.rawValue);\(color.rawValue)m\(text)");
    }
    
}