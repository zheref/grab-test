//
//  JSONParser.swift
//
//  Created by @zheref on 2/29/16.
//

import Foundation

internal class JSONParser {
    
    internal static func parse(data: NSData) throws -> JSON {
        do {
            let parsedObject : AnyObject =
                try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            return JSON(parsedObject: parsedObject)
        } catch {
            print("Could NOT parse JSON object")
            LogErrorHandler().handle(ErrorWrapper(error: error))
            
            throw error
        }
    }
    
}