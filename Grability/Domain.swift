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
    
    private var _appsCoordinator: AppsCoordinatorDelegate
    
    internal var appsCoordinator: AppsCoordinatorDelegate {
        get { return _appsCoordinator }
    }
    
    private var _selectedCategory: Category?
    
    internal var selectedCategory: Category? {
        get { return _selectedCategory }
        set (val) {
            _selectedCategory = val
        }
    }
    
    private var _lastTappedApp: App?
    
    internal var lastTappedVar: App? {
        get { return _lastTappedApp }
        set (val) {
            _lastTappedApp = val
        }
    }
    
    private var _selectedVariation: AppVariation = AppVariation.TopFreeApplications
    
    internal var selectedVariation: AppVariation {
        get { return _selectedVariation }
        set (val) {
            _selectedVariation = val
        }
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
    internal func getApps(amount: Int, returner: AppsAsyncReturner,
    thrower: ErrorAsyncThrower)
    {
        appsCoordinator.get(_selectedVariation, category: selectedCategory,
            amount: amount, returner: returner, thrower: thrower)
    }
    
    /**
     * Async return all the categories
     * - Parameter returner: Async returner closure to deliver categories
     * - Parameter thrower: Async error thrower closure to delegate error handlings
     */
    internal func getCategories(returner: CategoriesAsyncReturner, thrower: ErrorAsyncThrower) {
        
    }
    
}