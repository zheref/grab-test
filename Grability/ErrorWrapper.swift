//
//  ErrorWrapper.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/29/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

internal class ErrorWrapper {
    
    internal var _nsError: NSError?
    
    internal var _error: ErrorType?
    
    internal var isNs: Bool {
        get {
            if let _ = self._nsError {
                return true
            } else {
                return false
            }
        }
    }
    
    init(ns: NSError) {
        _nsError = ns
    }
    
    init(error: ErrorType) {
        _error = error
    }
    
}