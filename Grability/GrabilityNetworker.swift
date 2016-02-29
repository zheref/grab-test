//
//  GrabilityNetworker.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/28/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

/**
 * Base class for every networker withing this application
 **/
public class GrabilityNetworker {
    
    // CONSTANTS ----------------------------------------------------------------------------------
    
    /**
     * Base REST API URL
     **/
    private static let baseUrl: String = "https://itunes.apple.com/us/rss/"
    
    /**
     * Format used for data networking
     **/
    private static let format: String = "json"
    
}