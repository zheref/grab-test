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
internal class AppsCoordinator {
    
    // COMPUTED -----------------------------------------------------------------------------------
    
    internal var isNetworkAvailable: Bool {
        get {
            let status = Reach().connectionStatus()
            
            switch status {
            case .Unknown, .Offline:
                print("Not connected")
                return false
            case .Online(.WWAN):
                print("Connected via WWAN")
                return true
            case .Online(.WiFi):
                print("Connected via WiFi")
                return true
            }
        }
    }
    
    // METHODS ------------------------------------------------------------------------------------
    
    internal func getTopFreeApps(amount: Int, returner: AppsAsyncReturner) {
        if isNetworkAvailable {
            AppsNetworker.getInstance().retrieveTopFree(amount, returner: {
                (apps: [App]) in
                AppsDatastore.getInstance().updateTopFree(apps)
                returner(apps)
            })
        } else {
            AppsDatastore.getInstance().retrieveTopFree(amount, returner: returner)
        }
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
}