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
internal final class AppsCoordinator {
    
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
    internal static func getInstance() -> AppsCoordinator {
        return AppsCoordinator._instance
    }
    
    // INITIALIZERS -------------------------------------------------------------------------------
    
    /**
     * Main initializer (made private for singleton encapsulation purposes)
     */
    private init() {
        
    }
    
    // METHODS ------------------------------------------------------------------------------------
    
    internal func getTopFreeApps(amount: Int, returner: AppsAsyncReturner) {
        // TODO: Respond to network connectivity changes
        
        if GrabilityNetworker.isNetworkAvailable {
            AppsNetworker.getInstance().retrieveTopFree(amount, returner: {
                (apps: [App]) in
                AppsDatastore.getInstance().updateTopFree(apps, beingSupervisedBy: LogSupervisor())
                returner(apps)
            })
        } else {
            AppsDatastore.getInstance().retrieveTopFree(amount, returner: returner)
        }
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
}