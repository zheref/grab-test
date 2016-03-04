//
//  CategoriesDomain.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/4/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

internal class CategoriesDomain {
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    var _categoriesCoordinator: CategoriesCoordinatorDelegate
    
    var categoriesCoordinator: CategoriesCoordinatorDelegate {
        get { return _categoriesCoordinator }
    }
    
    // INITIALIZERS -------------------------------------------------------------------------------
    
    /**
    * Main initializer
    */
    init(coordinator: CategoriesCoordinatorDelegate) {
        self._categoriesCoordinator = coordinator
    }
    
    // METHODS ------------------------------------------------------------------------------------
    
    /**
     * Async return all the categories
     * - Parameter returner: Async returner closure to deliver categories
     * - Parameter thrower: Async error thrower closure to delegate error handlings
     */
    internal func getAll(returner: CategoriesAsyncReturner, thrower: ErrorAsyncThrower) {
        categoriesCoordinator.get(returner, thrower: thrower)
    }
    
}