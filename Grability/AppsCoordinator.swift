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
     * - Parameter amount Int: The amount of apps to request
     * - Parameter returner AppsAsyncReturner: The apps dispatcher closure to deliver the results
     * - Parameter thrower ErrorAsyncThrower: The error dispatcher closure to throw in error case
     */
    internal func get(variation: AppVariation, amount: Int, returner: AppsAsyncReturner,
    thrower: ErrorAsyncThrower) {
        let cacheKey = "apps:\(variation.rawValue):all"
            
        // TODO: Respond to network connectivity changes
        if GrabilityNetworker.isNetworkAvailable {
            AppsNetworker.shared.retrieve(variation, amount: amount, returner: {
                (apps: [App]) in
                AppsDatastore.shared.updateTopFree(apps, beingSupervisedBy: LogSupervisor())
                returner(apps)
            }, thrower: thrower)
        } else {
            AppsDatastore.shared.retrieveTopFree(amount, returner: returner)
        }
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
}