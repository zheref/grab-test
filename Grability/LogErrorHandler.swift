//
//  LogErrorHandler.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/29/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

/**
 * The most basic error handler using the common console log for printing notifications.
 * This is just for debugging purposes
 */
internal class LogErrorHandler : ErrorHandler {
    
    /**
     * Prints into console the specified error to handle
     */
    internal func handle(error: ErrorWrapper, whileDoing doing: String = "Not Specified") {
        if error.isNs {
            let err = error._nsError
            
            print("Unresolved error \(err!), \(err!.userInfo)")
        } else {
            let err = error._error
            
            print(error)
            
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Unknown error. Specified as ErrorType"
            dict[NSLocalizedFailureReasonErrorKey] =
            "There was an error while \(doing)"
            dict[NSUnderlyingErrorKey] = err as? AnyObject
            
            let theError = NSError(domain: "co.zheref.Grability", code: 9999, userInfo: dict)
            
            print("Unresolved error \(theError), \(theError.userInfo)")
        }
    }
    
    internal func handle(error: NSError) {
        
    }
    
}