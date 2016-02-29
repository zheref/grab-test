//
//  GrabilityDatastore.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/29/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

/**
 * Base class for every networker withing this application
 **/
internal class GrabilityDatastore {
    
    // CONSTANTS ----------------------------------------------------------------------------------
    
    init() {
        let dataHelper = CoreDataHelper.getInstance()
        let coordinator = dataHelper.persistentStoreCoordinator
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
}