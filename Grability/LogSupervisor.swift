//
//  LogSupervisor.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/29/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

/**
 * The most basic supervisor using the common console log for printing notifications.
 * This is just for debugging purposes
 */
internal class LogSupervisor : OperationSupervisor {
    
    /**
     * Prints into console the specified process name has been marked with the specified status
     */
    internal func notifyProcessWithName(name: String, markedAs status: OperationStatus) {
        print("Operation with name \(name) has been marked as \(status)")
    }
    
}