//
//  AppsDatastore.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/29/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

/**
 * Class responsible of managing all the processes to read/write apps from the related local DB
 **/
internal final class AppsDatastore : GrabilityDatastore {
    
    // SINGLETON ----------------------------------------------------------------------------------
    
    /**
    * Unique AppsDatastore singleton reference (lazy-loaded)
    **/
    private static var _instance: AppsDatastore = {
        return AppsDatastore()
    }()
    
    /**
     * Unique AppsDatastore singleton accesor
     **/
    internal static func getInstance() -> AppsDatastore {
        return AppsDatastore._instance
    }
    
    // CONSTANTS ----------------------------------------------------------------------------------
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    // INITIALIZERS -------------------------------------------------------------------------------
    
    /**
    * Main initializer (made private for singleton encapsulation purposes)
    **/
    private override init() {
        super.init()
    }
    
    // METHODS ------------------------------------------------------------------------------------
    
    /**
    * Retrieves the specified amount of apps from top free
    */
    internal func retrieveTopFree(amount: Int, returner: AppsAsyncReturner) {
        
    }
    
    internal func updateTopFree(apps: [App], beingSupervisedBy supervisor: OperationSupervisor) {
        let processName = "UPDATE_FREEAPPS_FROM_API_INTO_DB"
        
        supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Started)
        supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Finished)
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
}