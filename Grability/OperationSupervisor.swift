//
//  OperationSupervisor.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/29/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import Foundation

enum OperationStatus: String {
    case Started = "Started"
    case Aborted = "Aborted"
    case Finished = "Finished"
}

protocol OperationSupervisor {
    
    func notifyProcessWithName(name: String, markedAs status: OperationStatus)
    
}