//
//  App+CoreDataProperties.swift
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

extension App {

    @NSManaged var bundleId: String?
    @NSManaged var id: String?
    @NSManaged var link: String?
    @NSManaged var name: String?
    @NSManaged var title: String?
    @NSManaged var rights: String?
    @NSManaged var summary: String?
    @NSManaged var releaseDate: NSDate?
    @NSManaged var images: NSOrderedSet?
    @NSManaged var artist: Artist?
    @NSManaged var category: Category?

}
