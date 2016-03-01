//
//  AppsDatastore.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/29/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation
import CoreData

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
    internal static var shared: AppsDatastore {
        get { return AppsDatastore._instance }
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
    
    /**
     *
     */
    internal func updateTopFree(apps: [App], beingSupervisedBy supervisor: OperationSupervisor) {
        let processName = "UPDATE_FREEAPPS_FROM_API_INTO_DB"
        clearTopFree(supervisor)
        supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Started)
        CoreDataHelper.shared.saveContext()
        supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Finished)
    }
    
    /**
     * Clear the table related with the Top Free Apps entity completely
     */
    private func clearTopFree(supervisor: OperationSupervisor) {
        let processName = "CLEAR_TOPFREEAPPS_FROM_DB"
        
        if #available(iOS 9.0, *) {
            supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Started)
            
            let fetchRequest = NSFetchRequest(entityName: App.modelName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try CoreDataHelper.shared.executeRequest(deleteRequest)
                supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Finished)
            } catch let error as NSError {
                LogErrorHandler().handle(ErrorWrapper(ns: error))
                supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Aborted)
            }
        } else {
            supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Started)
            
            // Fallback on earlier versions
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = NSEntityDescription.entityForName(App.modelName,
                inManagedObjectContext: CoreDataHelper.shared.managedObjectContext!)
            fetchRequest.includesPropertyValues = false
            
            do {
                let results: NSArray = try CoreDataHelper.shared.managedObjectContext!
                    .executeFetchRequest(fetchRequest)
                
                for item in results {
                    CoreDataHelper.shared.managedObjectContext!
                        .deleteObject(item as! NSManagedObject)
                }
                
                supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Finished)
            } catch let error as NSError {
                LogErrorHandler().handle(ErrorWrapper(ns: error))
                supervisor.notifyProcessWithName(processName, markedAs: OperationStatus.Aborted)
            }
            
        }
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
}