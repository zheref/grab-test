//
//  Category.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/27/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation
import CoreData


internal class Category: NSManagedObject {

    private static let modelName: String = "Category"
    
    /**
     * Creates a new managed instance of a category based on the given arguments
     * - Parameter label String: The label to be displayed for the category as its name
     */
    internal static func fromArguments(id: String, label: String, link: String) -> Category {
        let category = CoreDataHelper.shared.newEntity(Category.modelName) as! Category
        
        category.id = id
        category.label = label
        
        let parts = link.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "/"))
        let isolatedLink = parts[5]
        
        category.link = isolatedLink
            
        return category
    }

}
