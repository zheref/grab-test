//
//  AppImage.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/27/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation
import CoreData


class AppImage: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    internal static func fromArguments(size: Int, withUrl link: String, forApp app: App) ->
    AppImage {
        
        let appImage = AppImage()
        appImage.size = size
        appImage.link = link
        appImage.app = app
        return appImage
    }

}
