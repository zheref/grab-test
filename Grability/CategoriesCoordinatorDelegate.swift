//
//  CategoriesCoordinatorDelegate.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/4/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

protocol CategoriesCoordinatorDelegate {
    
    func get(returner: CategoriesAsyncReturner, thrower: ErrorAsyncThrower)
    
    func memcacheCollectedCategories(categories: [Category])
    
}