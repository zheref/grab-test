//
//  AppsCoordinator.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/29/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

/**
 * Base class for every networker withing this application
 **/
internal final class AppsCoordinator : AppsCoordinatorDelegate {
    
    // SINGLETON ----------------------------------------------------------------------------------
    
    /**
     * Unique AppsCoordinator singleton reference (lazy-loaded)
     */
    private static var _instance: AppsCoordinator = {
        return AppsCoordinator()
    }()
    
    /**
     * Unique AppsCoordinator singleton accesor
     */
    internal static var shared: AppsCoordinator {
        get { return AppsCoordinator._instance }
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
     * - Parameter category Category: The category of the products that are wanted to be retrieved
     * - Parameter amount Int: The amount of apps to request
     * - Parameter returner AppsAsyncReturner: The apps dispatcher closure to deliver the results
     * - Parameter thrower ErrorAsyncThrower: The error dispatcher closure to throw in error case
     */
    internal func get(variation: AppVariation, category: Category?, amount: Int,
    returner: AppsAsyncReturner, thrower: ErrorAsyncThrower)
    {
        let cacheCategoryKey = category != nil ? category!.link : "all"
        let cacheKey = "apps:\(variation.rawValue):\(cacheCategoryKey)"
        
        if Memcache.shared.hasKey(cacheKey) {
            returner(Memcache.shared[cacheKey]! as! [App])
        } else {
            // TODO: Respond to network connectivity changes
            if GrabilityNetworker.isNetworkAvailable {
                AppsNetworker.shared.retrieve(variation, category: category, amount: amount,
                returner: {(apps: [App]) in
                    Memcache.shared.addOrUpdateKey(cacheKey, withData: apps)
                    AppsDatastore.shared.updateApps(apps, beingSupervisedBy: LogSupervisor())
                    
                    if category == nil {
                        self.collectAndMemcacheCategories(apps)
                    }
                    
                    returner(apps)
                }, thrower: thrower)
            } else {
                AppsDatastore.shared.retrieve(variation, category: category, amount: amount,
                    returner: {(apps: [App]) in
                        Memcache.shared.addOrUpdateKey(cacheKey, withData: apps)
                        returner(apps)
                    }, thrower: thrower)
            }
        }
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
    /**
     * Collect all the categories from the fetched apps and memcache them
     */
    private func collectAndMemcacheCategories(apps: [App]) {
        var categories = [Category]()
        
        for app in apps {
            if let categoryForApp = app.category {
                var existing = false
                
                for iteratedCategory in categories {
                    if iteratedCategory.label == categoryForApp.label {
                        existing = true
                    }
                }
                
                if existing {
                    continue
                } else {
                    categories.append(categoryForApp)
                }
            } else {
                continue
            }
        }
        
        CategoriesCoordinator.shared.memcacheCollectedCategories(categories)
    }
    
}