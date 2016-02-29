//
//  AppsNetworker.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/28/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

/**
 * Class responsible of managing all the processes to read/write apps from the related REST API
 **/
internal final class AppsNetworker : GrabilityNetworker {
    
    // SINGLETON ----------------------------------------------------------------------------------
    
    /**
     * Unique AppsNetworker singleton reference (lazy-loaded)
     **/
    private static var _instance: AppsNetworker = {
        return AppsNetworker()
    }()
    
    /**
     * Unique AppsNetworker singleton accesor
     **/
    internal static func getInstance() -> AppsNetworker {
        return AppsNetworker._instance
    }
    
    // CONSTANTS ----------------------------------------------------------------------------------
    
    // Reference: https://rss.itunes.apple.com/us/?urlDesc=
    
    /**
     * Route part for accessing top free applications feed
     **/
    private static let topFreeApplicationsRoute: String = "topfreeapplications"
    
    /**
     * Route part for accessing new applications feed (both free and paid)
     **/
    private static let newApplicationsRoute: String = "newapplications"
    
    /**
     * Route part for accessing new free applications feed
     **/
    private static let newFreeApplicationsRoute: String = "newfreeapplications"
    
    /**
     * Route part for accessing new paid applications feed
     **/
    private static let newPaidApplications: String = "newpaidapplications"
    
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
    internal func retrieveTopFree(amount: Int, returner: AppsAsyncReturner,
        thrower: ErrorAsyncThrower) {
            
        let url: NSURL =
            GrabilityNetworker.buildUrl(AppsNetworker.topFreeApplicationsRoute, forFeeding: amount)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data, response, error) in
            
            if let err = error {
                thrower(ErrorWrapper(error: err))
            } else {
                do {
                    let parsedData: JSON = try JSONParser.parse(data!)
                    returner(self.serializeJsonFeed(parsedData))
                } catch {
                    thrower(ErrorWrapper(error: error))
                }
            }
        }
        
        task.resume()
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
    /**
     * Return the route part stating how many items should be retrieved
     **/
    private func limitPart(limit: Int) -> String {
        return "limit=\(limit)"
    }
    
    /**
     * Serialize JSON dictionary of feeded data into Apps model managed objects
     */
    private func serializeJsonFeed(jsonFeed: JSON) -> [App] {
        print(jsonFeed.stringValue!)
        
        return [App]()
    }
    
}