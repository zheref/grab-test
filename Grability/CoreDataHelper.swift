//
//  CoreDataHelper.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/27/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation
import CoreData

/**
 * Class responsible of wrapping the commong access to a managed data store given the model
 **/
public class CoreDataHelper {
    
    private let dataDirectory: NSURL = NSFileManager.defaultManager()
        .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last! as NSURL
    
    // PROPERTIES ---------------------------------------------------------------------------------

    /**
     *
     **/
    private var modelName: String
    
    /**
     *
     **/
    private var datastoreFilename: String
    
    /**
     * Managed object model instance to handle data operations (loaded lazily)
     **/
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("Grability", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    /**
     * Middleware that handles the data-storage mechanism
     **/
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? =
            NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let documentsDirectory: NSURL = NSFileManager.defaultManager()
            .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last! as NSURL
        let url = documentsDirectory.URLByAppendingPathComponent(self.datastoreFilename)
        
        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]
        
        do {
            let persistentStore: NSPersistentStore? = try coordinator!
                .addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil,
                    URL: url, options: options)
        } catch {
            coordinator = nil
            self.handleError(error as NSError)
        }
        
        return coordinator
    }()
    
    /**
     *
     **/
    private lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        
        if coordinator == nil {
            return nil
        } else {
            var managedObjectContext = NSManagedObjectContext(
                concurrencyType: .MainQueueConcurrencyType
            )
            
            managedObjectContext.persistentStoreCoordinator = coordinator
            
            return managedObjectContext
        }
    }()
    
    /**
     * Common helper initializer
     **/
    init(modelName: String, datastoreFilename: String) {
        self.modelName = modelName
        self.datastoreFilename = datastoreFilename
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
    /**
     * States how a error thrown within this classes will be managed and finally shown both
     * to the user and developer, or instead propagated to be delegated its handling
     **/
    private func handleError(error: NSError) {
        var dict = [String: AnyObject]()
        dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
        dict[NSLocalizedFailureReasonErrorKey] =
        "There was an error creating or loading the application's saved data"
        dict[NSUnderlyingErrorKey] = error
        
        let theError = NSError(domain: "co.zheref.Grability", code: 9999, userInfo: dict)
        
        print("Unresolved error \(theError), \(theError.userInfo)")
        abort()
    }
    
}