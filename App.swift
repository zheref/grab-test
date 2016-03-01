//
//  App.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/27/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation
import CoreData


internal class App: NSManagedObject {
    
    internal static let modelName: String = "App"
    
    /**
     * Factory method allowing to create an App model instance based on its associated
     * JSON representation from the API
     */
    internal static func fromJson(json: JSON) -> App {
        let app = CoreDataHelper.getInstance().newEntity(App.modelName) as! App
        
        app.name = getLabelForKey("im:name", fromJson: json)
        app.summary = getLabelForKey("summary", fromJson: json)
        app.bundleId = getAttributeForKey("id", attribute: "im:bundleId", fromJson: json)
        app.id = getAttributeForKey("id", attribute: "im:id", fromJson: json)
        
        let appImagesRelation = app.mutableOrderedSetValueForKey("images")
        
        let smallImageJson = json["im:image"]![0]
        let smallImageUrl = getLabel(smallImageJson!)
        appImagesRelation.addObject(AppImage.fromArguments(1, withUrl: smallImageUrl))
        
        let mediumImageJson = json["im:image"]![1]
        let mediumImageUrl = getLabel(mediumImageJson!)
        appImagesRelation.addObject(AppImage.fromArguments(2, withUrl: mediumImageUrl))
        
        let largeImageJson = json["im:image"]![2]
        let largeImageUrl = getLabel(largeImageJson!)
        appImagesRelation.addObject(AppImage.fromArguments(3, withUrl: largeImageUrl))
        
        return app
    }
    
    private static func getLabelForKey(key: String, fromJson json: JSON) -> String {
        let jsonWrapper = json[key]!
        return getLabel(jsonWrapper)
    }
    
    private static func getAttributeForKey(key: String, attribute attr: String,
    fromJson json: JSON) -> String {
        
        let jsonWrapper = json[key]!
        return getAttribute(attr, fromJson: jsonWrapper)
    }
    
    private static func getLabel(json: JSON) -> String {
        let label = json["label"]!
        let labelStr = label.stringValue!
        return labelStr
    }
    
    private static func getAttribute(attribute: String, fromJson json: JSON) -> String {
        let jsonAttrs = json["attributes"]!
        let jsonAttr = jsonAttrs[attribute]!
        return jsonAttr.stringValue!
    }

}
