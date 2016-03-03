//
//  HTTPResources.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

internal class HTTPResources {
    
    /**
     * Gets an image from the network given its URI
     * - Parameter uri String: The URI of the image resource over the network
     */
    internal static func getImage(uri: String, by returner: ImageDataAsyncReturner,
    orFailWith thrower: ErrorAsyncThrower) {
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: uri)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                if let theError = error {
                    LogErrorHandler.shared.handle(ErrorWrapper(ns: theError))
                    thrower(ErrorWrapper(ns: theError))
                } else if let theData = data {
                    returner(theData)
                } else {
                    let theError = ErrorWrapper(ns: NSError(domain: "HTTPResources",
                        code: 123, userInfo: nil))
                    LogErrorHandler.shared.handle(theError)
                    thrower(theError)
                }
            }
        );
    }
    
}