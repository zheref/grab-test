//
//  ErrorHandler.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/29/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

internal protocol ErrorHandler {
    
    func handle(error: ErrorWrapper, whileDoing doing: String)
    
}