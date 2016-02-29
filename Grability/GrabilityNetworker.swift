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
internal class GrabilityNetworker {
    
    // CONSTANTS ----------------------------------------------------------------------------------
    
    /**
     * Base REST API URL
     **/
    private static let baseUrl: String = "https://itunes.apple.com"
    
    /**
     * Default locale path component for feed API
     **/
    private static let localePathComponent: String = "us"
    
    /**
     * Default base path component for feed API
     **/
    private static let basePathComponent: String = "rss"
    
    /**
     * Format used for data networking
     **/
    private static let format: String = "json"
    
    /**
     * Limit param name to specify how many items to retrieve on the feed
     **/
    private static let limitParamName: String = "limit"
    
    /**
     * Genre param name to specify what for what category the apps shoud be retrieved on the feed
     */
    private static let genreParamName: String = "genre"
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
    /**
     * Lorem ipsum
     */
    internal static func buildUrl(dataToFeed: String, forFeeding amountToFeed: Int,
    forGenre genre: String = "") -> NSURL {
        
        let components: NSURLComponents! = NSURLComponents(string: GrabilityNetworker.baseUrl)
        
        var routePartsStr: String = "/\(localePathComponent)/\(basePathComponent)/\(dataToFeed)/" +
            "\(limitParamName)=\(amountToFeed)"
        if genre != "" { routePartsStr += "/\(genreParamName)=\(genre)" }
        routePartsStr += "/\(format)"
        
        components.path = routePartsStr
        
        return components.URL!
    }
    
}