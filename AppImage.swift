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
    
    private static let modelName: String = "AppImage"

// Insert code here to add functionality to your managed object subclass
    
    /**
     *
     */
    internal static func fromArguments(size: Int, withUrl link: String, forApp app: App? = nil) ->
    AppImage {
        let appImage = CoreDataHelper.shared.newEntity(AppImage.modelName) as! AppImage
        
        appImage.size = size
        appImage.link = link
        
        if app != nil {
            appImage.setValue(app!, forKeyPath: "app")
        }
        
        return appImage
    }

}
