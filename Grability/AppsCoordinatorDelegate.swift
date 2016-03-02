//
//  AppsCoordinatorDelegate.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/1/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

protocol AppsCoordinatorDelegate {
    
    func get(variation: AppVariation, amount: Int, returner: AppsAsyncReturner,
        thrower: ErrorAsyncThrower)
    
}