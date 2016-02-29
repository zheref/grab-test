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
    
    // CLASS MEMBERS ------------------------------------------------------------------------------
    
    public static func getInstance() -> CoreDataHelper {
        return CoreDataHelper(modelName: "Grability", datastoreFilename: "Grability.sqlite")
    }
    
    // PROPERTIES ---------------------------------------------------------------------------------

    /**
     * Name of the managed object model to manage
     **/
    private var modelName: String
    
    /**
     * Name of the data store file name where to save the DB into the filesystem
     **/
    private var datastoreFilename: String
    
    /**
     * Managed object model instance to handle data operations (loaded lazily)
     **/
    private lazy var _managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("Grability", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    /**
     * Middleware that handles the data-storage mechanism
     **/
    private lazy var _persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? =
            NSPersistentStoreCoordinator(managedObjectModel: self._managedObjectModel)
        
        let documentsDirectory: NSURL = NSFileManager.defaultManager()
            .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last! as NSURL
        let url = documentsDirectory.URLByAppendingPathComponent(self.datastoreFilename)
        
        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]
        
        print("DEBUG: path to data file \(url)")
        
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
     * Persistent Store Coordinator public read-only accesor
     **/
    public var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        get { return _persistentStoreCoordinator }
    }
    
    /**
     *
     **/
    private lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self._persistentStoreCoordinator
        
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
    
    // INITIALIZERS -------------------------------------------------------------------------------
    
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