//
//  MemcacheObserver.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

internal protocol MemcacheObserver {
    
    func memcacheHasChanged(forKey key: String) -> Void
    
}