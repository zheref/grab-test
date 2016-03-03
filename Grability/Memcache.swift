//
//  Memcache.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

internal class Memcache {
    
    private typealias MemcacheCollection = [String: ([AnyObject], MemcacheObserver?)]
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    private var _data: MemcacheCollection
    
    // INITIALIZERS -------------------------------------------------------------------------------
    
    init() {
        _data = MemcacheCollection()
    }
    
    // SUBSCRIPT ----------------------------------------------------------------------------------
    
    internal subscript(cacheKey: String) -> [AnyObject]? {
        get {
            if let obj = _data[cacheKey] {
                return obj.0
            } else {
                return nil
            }
        }
    }
    
    // METHODS ------------------------------------------------------------------------------------
    
    /**
     * Caches a given object with the given key. If it's already there, it updates
     * - Parameter cacheKey String: Key with what the data will be cached
     * - Parameter dataItem [AnyObject]:
     */
    internal func addOrUpdateKey(cacheKey: String, withData dataItem: [AnyObject],
    beingWatchedBy dataObserver: MemcacheObserver? = nil) {
        if _data[cacheKey] == nil {
            _data[cacheKey] = (dataItem, dataObserver)
        } else {
            if dataObserver != nil {
                _data.updateValue((dataItem, dataObserver), forKey: cacheKey)
                dataObserver!.memcacheHasChanged(forKey: cacheKey)
            } else {
                let observer = _data[cacheKey]!.1
                _data.updateValue((dataItem, observer), forKey: cacheKey)
                
                if observer != nil {
                    observer!.memcacheHasChanged(forKey: cacheKey)
                }
            }
        }
    }
    
}