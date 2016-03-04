//
//  Domain.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/1/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

internal class Domain {
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    
    var _appsCoordinator: AppsCoordinatorDelegate
    
    var appsCoordinator: AppsCoordinatorDelegate {
        get { return _appsCoordinator }
    }
    
    // INITIALIZERS -------------------------------------------------------------------------------
    
    /**
     * Main initializer
     */
    init(coordinator: AppsCoordinatorDelegate) {
        self._appsCoordinator = coordinator
    }
    
    // METHODS ------------------------------------------------------------------------------------
    
    /**
     * Async return the top free apps.
     * - Parameter amount: Amount of items to retrieve
     * - Parameter returner: Closure who will receive the async returned items
     */
    internal func getTopFreeApps(amount: Int, returner: AppsAsyncReturner,
    thrower: ErrorAsyncThrower) {
        
        appsCoordinator.get(AppVariation.TopFreeApplications, amount: amount,
            returner: returner, thrower: thrower)
    }
    
    /**
     * Async return all the categories
     * - Parameter returner: Async returner closure to deliver categories
     * - Parameter thrower: Async error thrower closure to delegate error handlings
     */
    internal func getCategories(returner: CategoriesAsyncReturner, thrower: ErrorAsyncThrower) {
        
    }
    
}