//
//  CategoriesCoordinator.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

internal class CategoriesCoordinator : CategoriesCoordinatorDelegate {
    
    // CONSTANTS ----------------------------------------------------------------------------------
    
    let cacheKey = "categories:all"
    
    // SINGLETON ----------------------------------------------------------------------------------
    
    /**
    * Unique CategoriesCoordinator singleton reference (lazy-loaded)
    */
    private static var _instance: CategoriesCoordinator = {
        return CategoriesCoordinator()
    }()
    
    /**
     * Unique CategoriesCoordinator singleton accesor
     */
    internal static var shared: CategoriesCoordinator {
        get { return CategoriesCoordinator._instance }
    }
    
    // INITIALIZERS -------------------------------------------------------------------------------
    
    /**
    * Main initializer (made private for singleton encapsulation purposes)
    */
    private init() { }
    
    // METHODS ------------------------------------------------------------------------------------
    
    /**
    * Chooses where to take the data from (based on the circumstances) and dispatch them
    * through the delegated returner
    * - Parameter variation AppVariation: The variation of apps to retrieve
    * - Parameter amount Int: The amount of apps to request
    * - Parameter returner AppsAsyncReturner: The apps dispatcher closure to deliver the results
    * - Parameter thrower ErrorAsyncThrower: The error dispatcher closure to throw in error case
    */
    internal func get(returner: CategoriesAsyncReturner, thrower: ErrorAsyncThrower) {
        if Memcache.shared.hasKey(cacheKey) {
            returner(Memcache.shared[cacheKey]! as! [Category])
        } else {
            // TODO: Query the local Core Data DB
        }
    }
    
    /**
     * Memcache the categories collected when retrieving apps
     * - Parameter categories [Category]: Collected categories to be memcached
     */
    internal func memcacheCollectedCategories(categories: [Category]) {
        Memcache.shared.addOrUpdateKey(cacheKey, withData: categories)
    }
    
}