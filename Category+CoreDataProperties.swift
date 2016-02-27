//
//  Category+CoreDataProperties.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/27/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Category {

    @NSManaged var label: String?
    @NSManaged var id: String?
    @NSManaged var link: String?
    @NSManaged var apps: App?

}
